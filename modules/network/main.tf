data "azurerm_resource_group" "rg" {
  name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}


resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-%s-vnet", var.owner_custom, var.purpose_custom)
  location            = var.location
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
  address_space       = var.address_space

}


resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name = each.value["name"]
  address_prefixes = each.value["address_space"]
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg
  name = each.value["name"]
  location = var.location
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}

# resource "azurerm_subnet_network_security_group_association" "nsg_association" {
#   for_each = var.nsg_association
#   subnet_id = azurerm_subnet.subnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
  
# }