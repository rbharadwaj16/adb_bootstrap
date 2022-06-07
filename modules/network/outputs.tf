output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
    value = tomap({
        for k, s in azurerm_subnet.subnet : k => s.id
    })
  
}

output "nsg_id" {
    value = tomap({
        for k,s in azurerm_network_security_group.nsg: k => s.id
    })
  
}