data "azurerm_log_analytics_workspace" "shared" {
  resource_group_name = "example-3-shared"
  name                = "${var.resource_prefix}3-logs"
}

resource "azurerm_application_insights" "main" {
  name                = "${var.resource_prefix}3-${var.environment}-appinsights"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  workspace_id        = data.azurerm_log_analytics_workspace.shared.id
  application_type    = "web"
}