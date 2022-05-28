resource "azurerm_resource_group" "rg" {
  name     = format("rg-%s-%s-%s",var.owner, var.purpose, var.location)
  location = var.location
}