terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.109.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = "" # Add subscription id
  features {}
}