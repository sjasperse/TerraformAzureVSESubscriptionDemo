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