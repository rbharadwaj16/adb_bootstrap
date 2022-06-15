locals {
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}
data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "adb_kv" {
  name                       = format("kv-%s-%s", var.owner_custom, var.purpose_custom)
  location                   = var.location
  resource_group_name        = local.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  sku_name                   = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set"
    ]
  }
}
