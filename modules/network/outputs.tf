output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
    value = tomap({
        for k, s in azurerm_subnet.subnet : k => s.id
    })
  
}

output "public_subnet_id" {
    value = azurerm_subnet.subnet["subnet1"].id
  
}

output "private_subnet_id" {
    value = azurerm_subnet.subnet["subnet2"].id

}

output "private_link_subnet" {
    value = azurerm_subnet.subnet["subnet3"].id
  
}

output "firewall_subnet" {
  value = azurerm_subnet.subnet["subnet4"].id
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