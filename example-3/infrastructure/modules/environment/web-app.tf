resource "azurerm_service_plan" "main" {
  name                = "${var.resource_prefix}3-${local.locationSafeName}-app-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "main" {
  name                            = "${var.resource_prefix}3-${local.locationSafeName}-app"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_service_plan.main.location
  service_plan_id                 = azurerm_service_plan.main.id

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insights_connection_string
  }
}
