locals {
  locationSafeName = lower(replace(var.location, " ", ""))
}

resource "azurerm_resource_group" "main" {
  name     = "example-3-${local.locationSafeName}"
  location = var.location
}
