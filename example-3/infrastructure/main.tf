terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.14.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

module "eastus2" {
  source = "./modules/environment"

  resource_prefix = var.resource_prefix
  subscription_id = var.subscription_id
  location = "East US 2"

  app_insights_connection_string = azurerm_application_insights.main.connection_string
}

module "central" {
  source = "./modules/environment"

  resource_prefix = var.resource_prefix
  subscription_id = var.subscription_id
  location = "Central US"

  app_insights_connection_string = azurerm_application_insights.main.connection_string
}
