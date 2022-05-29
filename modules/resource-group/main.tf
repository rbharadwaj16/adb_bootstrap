resource "azurerm_resource_group" "rg" {
  name     = format("rg-%s-%s", var.owner, var.purpose)
  location = var.location
}