provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "omop_rg" {
  name     = "${var.prefix}-${var.environment}-omop-rg"
  location = var.omop_rg_location
}

resource "azurerm_key_vault" "app_service_settings" {
  name                       = "${var.prefix}-${var.environment}-omop-kv"
  location                   = azurerm_resource_group.omop_rg.location
  resource_group_name        = azurerm_resource_group.omop_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "list",
    ]

    secret_permissions = [
      "list",
      "set",
      "get",
      "delete",
      "purge",
      "recover",
    ]
  }
}

resource "azurerm_key_vault_secret" "url" {
  name         = "datasource-url"
  value        = "jdbc:sqlserver://${var.prefix}-${var.environment}-omop-sql-server.database.windows.net:1433;database=${var.prefix}_${var.environment}_omop_db"
  key_vault_id = azurerm_key_vault.app_service_settings.id
}

resource "azurerm_key_vault_secret" "password" {
  name         = "omop-password"
  value        = "${var.omop_password}"
  key_vault_id = azurerm_key_vault.app_service_settings.id
}

resource "azurerm_key_vault_access_policy" "app_service_kv" {
  key_vault_id = azurerm_key_vault.app_service_settings.id
  tenant_id    = azurerm_app_service.omop_broadsea.identity.0.tenant_id
  object_id    = azurerm_app_service.omop_broadsea.identity.0.principal_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}

resource "local_file" "source-source-daimon" {
  filename = var.source_source_daimon_path
  content  = local.source-source-daimon
}

resource "azurerm_storage_account" "omop_sa" {
  name                     = "${var.prefix}${var.environment}omopsa"
  resource_group_name      = azurerm_resource_group.omop_rg.name
  location                 = azurerm_resource_group.omop_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "atlas" {
  name                  = "atlas"
  storage_account_name  = azurerm_storage_account.omop_sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "source_source_daimon" {
  name                   = "source_source_daimon.sql"
  storage_account_name   = azurerm_storage_account.omop_sa.name
  storage_container_name = azurerm_storage_container.atlas.name
  type                   = "Block"
  source                 = "../sql/source_source_daimon.sql"
}

/*
resource "azurerm_storage_container" "data" {
  name                  = "synpuf1k"
  storage_account_name  = azurerm_storage_account.omop_sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "synpuf1k_5.2.2.zip"
  storage_account_name   = azurerm_storage_account.omop_sa.name
  storage_container_name = azurerm_storage_container.data.name
  type                   = "Block"
  source                 = "../synpuf_data/synpuf1k_omop_cdm_5.2.2.zip"
}
*/

resource "azurerm_mssql_server" "omop_sql_server" {
  name                         = "${var.prefix}-${var.environment}-omop-sql-server"
  resource_group_name          = azurerm_resource_group.omop_rg.name
  location                     = azurerm_resource_group.omop_rg.location
  version                      = "12.0"
  administrator_login          = "omop_admin"
  administrator_login_password = var.omop_password
  minimum_tls_version          = "1.2"
  tags = {
    environment = var.environment
  }
}

resource "azurerm_sql_firewall_rule" "open_firewall" {
  name                = "SQLFirewallRule1"
  resource_group_name = azurerm_resource_group.omop_rg.name
  server_name         = azurerm_mssql_server.omop_sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  name                = "SQLFirewallRule2"
  resource_group_name = azurerm_resource_group.omop_rg.name
  server_name         = azurerm_mssql_server.omop_sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_database" "OHDSI-CDMV5" {
  name           = "${var.prefix}_${var.environment}_omop_db"
  server_id      = azurerm_mssql_server.omop_sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = var.omop_db_size
  sku_name       = var.omop_db_sku
  zone_redundant = true

  # initialize database by creating tables and schemas
  provisioner "local-exec" {
        command = "sqlcmd -U omop_admin -P ${var.omop_password} -S ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net -d ${var.prefix}_${var.environment}_omop_db -i '../sql/OMOP_CDM_sql_server_ddl.sql' -o ${var.log_file}"
  }

  # optionally create staging tables to aid in loading clinical data into the CDM
  /*
  provisioner "local-exec" {
        command = "sqlcmd -U omop_admin -P ${var.omop_password} -S ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net -d ${var.prefix}_${var.environment}_omop_db -i '../sql/OMOP_CDM_sql_server_staging_ddl.sql' -o ${var.log_file}"
  }

  # import cdm v5 vocabulary
  provisioner "local-exec" {
        command = "../scripts/vocab_import.sh ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net ${var.prefix}_${var.environment}_omop_db omop_admin ${var.omop_password}"
  }

  # convert vocabulary table columns from varchar to date
  provisioner "local-exec" {
      command = "sqlcmd -U omop_admin -P ${var.omop_password} -S ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net -d ${var.prefix}_${var.environment}_omop_db -i '../sql/convert_varchar_to_date.sql' -o ${var.log_file}"
  }

  # import synpuf data
  provisioner "local-exec" {
        command = "../scripts/synpuf_data_import.sh ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net ${var.prefix}_${var.environment}_omop_db omop_admin ${var.omop_password}"
  }

  # add indices and primary keys
  provisioner "local-exec" {
      command = "sqlcmd -U omop_admin -P ${var.omop_password} -S ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net -d ${var.prefix}_${var.environment}_omop_db -i .'./sql/OMOP_CDM_sql_server_indexes.sql' -o ${var.log_file}"
  }

  # add foreign key constraints
  provisioner "local-exec" {
      command = "sqlcmd -U omop_admin -P ${var.omop_password} -S ${var.prefix}-${var.environment}-omop-sql-server.database.windows.net -d ${var.prefix}_${var.environment}_omop_db -i '../sql/OMOP_CDM_sql_server_constraints.sql' -o ${var.log_file}"
  }
}

# This creates the plan that the service use
resource "azurerm_app_service_plan" "omop_asp" {
  name                = "${var.prefix}-${var.environment}-omop-asp"
  location            = "${azurerm_resource_group.omop_rg.location}"
  resource_group_name = "${azurerm_resource_group.omop_rg.name}"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# This creates the Broadsea app service definition
resource "azurerm_app_service" "omop_broadsea" {
  name                = "${var.prefix}-${var.environment}-omop-broadsea"
  location            = "${azurerm_resource_group.omop_rg.location}"
  resource_group_name = "${azurerm_resource_group.omop_rg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.omop_asp.id}"

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|${var.broadsea_image}:${var.broadsea_image_tag}"
    always_on        = true
  }

  app_settings = {
    "WEBAPI_RELEASE" = "2.9.0"
    "WEBAPI_WAR" =  "WebAPI-2.9.0.war"
    "WEBSITES_PORT" = "8080"
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "1800"
    //"WEBAPI_URL" = "https://${var.prefix}-${var.environment}-omop-broadsea.azurewebsites.net:8080/"
    "SQL_SERVER_NAME" = "${var.prefix}-${var.environment}-omop-sql-server.database.windows.net"
    "SQL_DB_NAME" = "${var.prefix}_${var.environment}_omop_db"
    "WEBAPI_SOURCES" = "https://${var.prefix}-${var.environment}-omop-broadsea.azurewebsites.net/WebAPI/source"
    "OMOP_PASSWORD" = "@Microsoft.KeyVault(VaultName=${var.prefix}-${var.environment}-omop-kv;SecretName=omop-password;SecretVersion=${azurerm_key_vault_secret.password.version})"
    "env" = "webapi-mssql"
    "security_origin" = "*"
    "datasource.driverClassName" = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    "datasource.url" = "@Microsoft.KeyVault(VaultName=${var.prefix}-${var.environment}-omop-kv;SecretName=datasource-url;SecretVersion=${azurerm_key_vault_secret.url.version})"
    "datasource.cdm.schema" = "cdm"
    "datasource.ohdsi.schema" = "webapi"
    "datasource.username" = "omop_admin"
    "datasource.password" = "@Microsoft.KeyVault(VaultName=${var.prefix}-${var.environment}-omop-kv;SecretName=omop-password;SecretVersion=${azurerm_key_vault_secret.password.version})"
    "spring.jpa.properties.hibernate.default_schema" = "webapi"
    "spring.jpa.properties.hibernate.dialect" = "org.hibernate.dialect.SQLServer2012Dialect"
    "spring.batch.repository.tableprefix" = "${var.prefix}_${var.environment}_omop_db.webapi.BATCH_"
    "flyway.datasource.driverClassName" = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    "flyway.datasource.url" = "@Microsoft.KeyVault(VaultName=${var.prefix}-${var.environment}-omop-kv;SecretName=datasource-url;SecretVersion=${azurerm_key_vault_secret.url.version})"
    "flyway.schemas" = "webapi"
    "flyway.placeholders.ohdsiSchema" = "webapi"
    "flyway.datasource.username" = "omop_admin"
    "flyway.datasource.password" = "@Microsoft.KeyVault(VaultName=${var.prefix}-${var.environment}-omop-kv;SecretName=omop-password;SecretVersion=${azurerm_key_vault_secret.password.version})"
    "flyway.locations" = "classpath:db/migration/sqlserver"
  }

  storage_account {
    name = "${var.prefix}-${var.environment}-omop-sa-mount"
    type = "AzureBlob"
    account_name = "${var.prefix}${var.environment}omopsa"
    share_name = "atlas"
    access_key = azurerm_storage_account.omop_sa.primary_access_key
    mount_path = "/usr/local/tomcat/webapps/atlas/js/tf_config"
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_storage_container.atlas
  ]
}

# This creates the Broadsea app service definition
resource "azurerm_app_service" "omop_webtools" {
  name                = "${var.prefix}-${var.environment}-omop-webtools"
  location            = "${azurerm_resource_group.omop_rg.location}"
  resource_group_name = "${azurerm_resource_group.omop_rg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.omop_asp.id}"

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|${var.webtools_image}:${var.webtools_image_tag}"
    always_on        = true
  }

  app_settings = {
    "WEBSITES_PORT" = "8787"
    "USER" = "${var.webtools_user}"
    "PASSWORD" =  "${var.webtools_password}"
  }

  identity {
    type = "SystemAssigned"
  }
}
