# outputs.tf
output "webapp_url" {
  description = "URL of the deployed Azure Web App"
  value       = azurerm_app_service.webapp.default_site_hostname
}
