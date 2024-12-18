resource "azurerm_key_vault" "main" {
  name                        = "${var.resource_prefix}2-kv"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization   = true

  sku_name = "standard"
}