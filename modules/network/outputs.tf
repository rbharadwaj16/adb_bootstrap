# output "vnet_id" {
#     value = azurerm_virtual_network.vnet.id
# }

output "virtual_network_id" {
    value = tomap({
        for k, s in azurerm_virtual_network.vnet : k => s.id
    })
  
}