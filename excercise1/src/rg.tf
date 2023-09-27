
# Creacion  Resource Group Region A - EASTUS
resource "azurerm_resource_group" "rg1" {
  name     = var.rg1
  location = var.lct
  tags     = var.tgs
}

# Creacion  Resource Group Region B - West US
resource "azurerm_resource_group" "rg2" {
  name     = var.rg2
  location = var.lct1
  tags     = var.tgs
}