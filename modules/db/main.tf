
locals {
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}

resource "random_id" "username" {
    byte_length = 10
  
}
resource "random_password" "password" {
  length           = 10
  special          = true
}

resource "azurerm_key_vault_secret" "db_un" {
  name         = "db-username"
  value        = random_id.username.hex
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "db_pw" {
  name         = "db-password"
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_mssql_server" "sql-server" {
  name                         = format("sqlserver-%s-%s", var.owner_custom, var.purpose_custom)
  resource_group_name          = local.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = azurerm_key_vault_secret.db_un.value
  administrator_login_password = azurerm_key_vault_secret.db_pw.value
}

resource "azurerm_mssql_database" "sql-db" {
    name = "metastoredb"
    server_id = azurerm_mssql_server.sql-server.id
    sku_name = "Basic"    
}

resource "azurerm_private_dns_zone" "db-dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = local.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "db-dns-link" {
    name = format("db-dns-%s-%s-link", var.owner_custom, var.purpose_custom)
    resource_group_name          = local.resource_group_name
    private_dns_zone_name = azurerm_private_dns_zone.db-dns.name
    virtual_network_id = var.vnet_id
  
}
resource "azurerm_private_endpoint" "sql-server-pe" {
  name = format("sqlserver-%s-%s-pe", var.owner_custom, var.purpose_custom)
  resource_group_name          = local.resource_group_name
  location                     = var.location
  subnet_id = var.private_link_subnet


    private_dns_zone_group {
    name                 = "private-db-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.db-dns.id]
  }

  private_service_connection {
    name = "sql-db-pe-connection"
    private_connection_resource_id = azurerm_mssql_server.sql-server.id
    is_manual_connection = false
    subresource_names = ["sqlServer"]
  }
}