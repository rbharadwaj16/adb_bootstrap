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
}