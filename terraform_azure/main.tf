# main.tf
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "webapp_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "webapp_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.webapp_rg.location
  resource_group_name = azurerm_resource_group.webapp_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = var.webapp_name
  location            = azurerm_resource_group.webapp_rg.location
  resource_group_name = azurerm_resource_group.webapp_rg.name
  app_service_plan_id = azurerm_app_service_plan.webapp_plan.id

  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://index.docker.io"
  }
}
