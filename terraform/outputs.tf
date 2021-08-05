output "app_service_default_hostname_atlas" {
  value = "https://${azurerm_app_service.omop_app_service.default_site_hostname}/atlas"
}
