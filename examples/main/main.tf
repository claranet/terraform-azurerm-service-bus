terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.28"
    }
  }
}

provider "azurerm" {
  features {}
}
