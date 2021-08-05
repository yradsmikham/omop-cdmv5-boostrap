variable "prefix" {
  type = string
}

variable "environment" {
  type = string
  default = "dev"
}

variable "omop_rg_location" {
  type = string
  default = "westus2"
}

variable "omop_password" {
  type = string
}

variable "source_source_daimon_path" {
  type = string
  default = "../sql/source_source_daimon.sql"
}

locals {
  source-source-daimon = <<-EOT
  -- OHDSI CDM source
  INSERT INTO webapi.source( source_id, source_name, source_key, source_connection, source_dialect)
  VALUES (1, 'OHDSI CDM V5 Database', 'OHDSI-CDMV5',
    'jdbc:sqlserver://${var.prefix}-${var.environment}-omop-sql-server.database.windows.net:1433;database=${var.prefix}_${var.environment}_omop_db;user=omop_admin;password=${var.omop_password}', 'sql server');

  -- CDM daimon
  INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1, 1, 0, 'dbo', 2);

  -- VOCABULARY daimon
  INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2, 1, 1, 'dbo', 2);

  -- RESULTS daimon
  INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3, 1, 2, 'webapi', 2);

  -- EVIDENCE daimon
  INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 1, 3, 'webapi', 2);

  EOT
}

variable "omop_db_size" {
  type = string
  default = 20 # max size gb
}

variable "omop_db_sku" {
  type = string
  default = "BC_Gen5_10"
}

variable log_file {
  description = "Log file name to create with the seeding results."
  default     = "db-init.log"
}

variable "docker_image" {
  description = "Docker image for OHDSI WebAPI and Web tools"
  default = "yradsmikham/ohdsi-webapi-and-webtools"
}

variable "docker_image_tag" {
  description = "Docker image tag for OHDSI WebAPI and Web tools"
  default = "latest"
}
