terraform {
  backend "azurerm" {
  }
  required_providers {
      azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.94.0"
      }
    }
}

provider "azurerm" {
    features {}
}

module "rg" {
  source   = "./modules/resource-group"
  owner    = var.owner
  purpose  = var.purpose
  location = var.location
}

