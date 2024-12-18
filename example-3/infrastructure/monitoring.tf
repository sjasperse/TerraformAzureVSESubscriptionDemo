resource "azurerm_resource_group" "monitoring" {
  name     = "example-3-monitoring"
  location = "East US 2"
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.resource_prefix}3-logs"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "main" {
  name                = "${var.resource_prefix}3-appinsights"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
}