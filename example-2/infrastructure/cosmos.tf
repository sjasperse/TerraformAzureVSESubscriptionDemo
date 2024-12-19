resource "azurerm_cosmosdb_account" "main" {
  name                = "${var.resource_prefix}2-cosmos"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"

  geo_location {
    location = azurerm_resource_group.main.location
    failover_priority = 0
  }

  consistency_policy {
    consistency_level = "Eventual"
  }
}

resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "Main"
  resource_group_name = azurerm_cosmosdb_account.main.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name
}

resource "azurerm_cosmosdb_sql_container" "stuff" {
  name                  = "Stuff"
  resource_group_name   = azurerm_cosmosdb_account.main.resource_group_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_paths   = ["/pk"]
  partition_key_version = 1
  throughput            = 400
}

resource "azurerm_key_vault_secret" "cosmos_connection_string" {
  key_vault_id = azurerm_key_vault.main.id
  name = "CosmosConnectionString"
  value = azurerm_cosmosdb_account.main.primary_sql_connection_string
}

resource "azurerm_cosmosdb_sql_role_assignment" "CurrentUser_CosmosDataContributor" {
  resource_group_name = azurerm_cosmosdb_account.main.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name

  role_definition_id  = "${azurerm_cosmosdb_account.main.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002" # Azure Cosmos DB Built-in Data Contributor
  principal_id        = data.azurerm_client_config.current.object_id
  scope               = azurerm_cosmosdb_account.main.id # this role is a cosmos role, and it needs to be applied at the cosmos account or deeper
}