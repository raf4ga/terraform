# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "720ba496-e3ed-457c-bb17-9c0a42c02817"
  client_secret   = var.client_secret
  tenant_id       = "87303345-a08d-4602-bc5d-60d64010d5b7"
  subscription_id = "37f88dec-f8f1-4f9d-b8c4-e9c951193b70"
}


   