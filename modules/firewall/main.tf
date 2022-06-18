locals {
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}


resource "azurerm_public_ip" "public-ip" {
  name                = format("public-ip-%s-%s", var.owner_custom, var.purpose_custom)
  location            = var.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "adb-firewall" {
  name                = format("firewall-%s-%s", var.owner_custom, var.purpose_custom)
  location            = var.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                 = "adb_configuration"
    subnet_id            = var.fw_subnet_id
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }
}

resource "azurerm_firewall_application_rule_collection" "adb_application_rules" {
  name                = "adb-control-plane-app-rules"
  azure_firewall_name = azurerm_firewall.adb-firewall.name
  resource_group_name = local.resource_group_name
  priority = 200
  action = "Allow" 

  rule {
    name = "artifact-and-log-blob-storage"
    source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
    target_fqdns = ["dbartifactsprodauste.blob.core.windows.net", "arprodaustea1.blob.core.windows.net", "arprodaustea2.blob.core.windows.net", "arprodaustea3.blob.core.windows.net", "arprodaustea4.blob.core.windows.net", "arprodaustea5.blob.core.windows.net", "arprodaustea6.blob.core.windows.net", "arprodaustea7.blob.core.windows.net", "arprodaustea8.blob.core.windows.net", "arprodaustea9.blob.core.windows.net", "arprodaustea10.blob.core.windows.net", "arprodaustea11.blob.core.windows.net", "arprodaustea12.blob.core.windows.net", "arprodaustea13.blob.core.windows.net", "arprodaustea14.blob.core.windows.net", "arprodaustea15.blob.core.windows.net", "dbartifactsprodaustse.blob.core.windows.net", "dblogprodausteast.blob.core.windows.net"]
     protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "adb-root-dbfs"
    source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
    target_fqdns = ["dbstorageadq5ie3yqruhe.blob.core.windows.net"]
     protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "adb-relay-ssc-tunnel"
    source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
    target_fqdns = ["tunnel.australiaeast.azuredatabricks.net"]
     protocol {
      port = "443"
      type = "Https"
    }
  }

  rule {
    name = "adb-eventhub-endpoint"
    source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
    target_fqdns = ["prod-australiaeast-observabilityeventhubs.servicebus.windows.net"]
     protocol {
      port = "443"
      type = "Https"
    }
  }
}


resource "azurerm_firewall_network_rule_collection" "adb_network_rules" {
  name                = "adb-control-plane-network-rules"
  azure_firewall_name = azurerm_firewall.adb-firewall.name
  resource_group_name = local.resource_group_name
  priority            = 200
  action              = "Allow"

  rule {
      name = "adb-webapp"
      source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
      destination_ports = ["443"]
      destination_addresses = ["13.75.218.172/32"]
      protocols = ["Any"]
  }

  rule {
      name = "extended-infrastructure"
      source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
      destination_ports = ["443"]
      destination_addresses = ["20.53.145.128/28"]
      protocols = ["Any"]
  }
}

resource "azurerm_route_table" "adb-route-table" {
  name                          = "adb-route-table"
  location                      = var.location
  resource_group_name           = local.resource_group_name

  route {
    name           = "to-firewall"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.adb-firewall.ip_configuration[0].private_ip_address
  }

  route {
      name = "to-scc-relay"
      address_prefix = "13.75.164.240/28"
      next_hop_type = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "adb-pubic-rt-assocation" {
  subnet_id      = var.rt_public_subnet
  route_table_id = azurerm_route_table.adb-route-table.id
}

resource "azurerm_subnet_route_table_association" "adb-private-rt-assocation" {
  subnet_id      = var.rt_private_subnet
  route_table_id = azurerm_route_table.adb-route-table.id
}