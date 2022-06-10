terraform {
  backend "azurerm" {
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.94.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source         = "./modules/resource-group"
  owner          = var.owner
  purpose        = var.purpose
  location       = var.location
  org            = var.org
  owner_custom   = var.owner_custom
  purpose_custom = var.purpose_custom
}

module "network" {
  source = "./modules/network"
  owner_custom   = var.owner_custom
  purpose_custom = var.purpose_custom
  address_space  = var.address_space
  location       = var.location
  subnets = var.subnets
  nsg = var.nsg
  depends_on = [module.rg]
}

 module "adb" {
   source = "./modules/adb"
   owner_custom   = var.owner_custom
   purpose_custom = var.purpose_custom
   vnet_id = module.network.vnet_id
   depends_on = [module.network]
   public_subnet_network_security_group_association_id = module.network.public_nsg_association
   private_subnet_network_security_group_association_id = module.network.private_nsg_association 
 }