resource "azurerm_resource_group" "rg" {
  name     = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
  location = var.location

  tags = {
    Owner = var.owner
    Client = var.org
    Purpose = var.purpose
  }
}