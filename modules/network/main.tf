data "azurerm_resource_group" "rg" {
  name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}


resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-%s-vnet", var.owner_custom, var.purpose_custom)
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space

}


resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name = each.value["name"]
  address_prefixes = each.value["address_space"]
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg
  name = each.value["name"]
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}