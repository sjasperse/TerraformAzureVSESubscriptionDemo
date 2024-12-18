resource "azurerm_service_plan" "main" {
  name                = "${var.resource_prefix}2-app-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "main" {
  name                = "${var.resource_prefix}2-app"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id
  key_vault_reference_identity_id = azurerm_user_assigned_identity.WebApp.id

  identity {
    type = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.WebApp.id ]
  }

  site_config {
    application_stack {
      dotnet_version = "8.0" 
    }
  }

  app_settings = {
    "ConnectionStrings__Cosmos" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.cosmos_connection_string.versionless_id})"
  }
}

resource "azurerm_user_assigned_identity" "WebApp" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "${var.resource_prefix}2-app-mid"
}

resource "azurerm_role_assignment" "WebApp_KVS" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.WebApp.principal_id
}
