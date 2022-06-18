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
      protocols = ["https"]
  }

  rule {
      name = "extended-infrastructure"
      source_addresses = ["10.10.1.0/26","10.10.1.64/26"]
      destination_ports = ["443"]
      destination_addresses = ["20.53.145.128/28"]
      protocols = ["https"]
  }
}