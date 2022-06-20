output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
    value = tomap({
        for k, s in azurerm_subnet.subnet : k => s.id
    })
  
}

output "public_network_id" {
    value = azurerm_subnet.subnet.id["public_subnet"]
  
}
output "nsg_id" {
    value = tomap({
        for k,s in azurerm_network_security_group.nsg: k => s.id
    })
}

output "public_nsg_association" {
    value = azurerm_subnet_network_security_group_association.nsg_association["subnet1"].id
}

output "private_nsg_association" {
    value = azurerm_subnet_network_security_group_association.nsg_association["subnet2"].id
 }