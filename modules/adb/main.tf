data "azurerm_resource_group" "rg" {
  name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}

resource "azurerm_databricks_workspace" "adb" {
    name = format("adb-%s-%s", var.owner_custom, var.purpose_custom)
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    sku = "premium"

    custom_parameters {
      no_public_ip = true
      virtual_network_id = var.vnet_id
      public_subnet_name = "public_subnet"
      private_subnet_name = "private_subnet"
    }
  
}