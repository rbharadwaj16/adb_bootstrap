data "azurerm_resource_group" "rg" {
  name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}


resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-%s-vnet", var.owner_custom, var.purpose_custom)
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = [var.address_space]
  
}
