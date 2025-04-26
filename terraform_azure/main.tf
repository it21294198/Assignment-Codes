# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a random string to ensure uniqueness for ACR name
resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Container Registry with unique name
resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# App Service Plan with Standard tier (instead of Premium)
resource "azurerm_service_plan" "app_plan" {
  name                = "${var.webapp_name}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "S1" # Using Standard tier instead of Premium
}

# Web App for Containers
resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.webapp_name}${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on = true
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
    container_registry_use_managed_identity = false
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = azurerm_container_registry.acr.admin_password
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_ENABLE_CI"                    = "true"
  }

  depends_on = [azurerm_container_registry.acr]
}

# Outputs to be used in GitHub Actions
output "resource_group_name" {
  value     = azurerm_resource_group.rg.name
  sensitive = false
}

output "webapp_name" {
  value     = azurerm_linux_web_app.webapp.name
  sensitive = false
}

output "acr_name" {
  value     = azurerm_container_registry.acr.name
  sensitive = false
}

output "acr_login_server" {
  value     = azurerm_container_registry.acr.login_server
  sensitive = false
}

output "acr_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}
