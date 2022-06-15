locals {
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}

resource "azurerm_databricks_workspace" "adb" {
  name                = format("adb-%s-%s", var.owner_custom, var.purpose_custom)
  resource_group_name = local.resource_group_name
  location            = var.location
  sku                 = "premium"

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = var.vnet_id
    public_subnet_name                                   = "public_subnet"
    private_subnet_name                                  = "private_subnet"
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
  }

}
