# Creacion Vnet 1 y subnet Zona A - EASTUS
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet01" {
    name                 = var.snet01
    resource_group_name  = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_subnet" "snet02" {
    name                 = var.snet02
    resource_group_name  = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = ["10.0.1.0/26"]
}


resource "azurerm_subnet" "snet03" {
    name                 = var.snet03 
    resource_group_name  = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = ["10.0.2.0/24"]
}
# Creacion Vnet 2 y subnet Zona B - West US
resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  tags                = var.tgs
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet01B" {
    name                 = var.snet01B
    resource_group_name  = azurerm_resource_group.rg2.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_subnet" "snet02B" {
    name                 = var.snet02B
    resource_group_name  = azurerm_resource_group.rg2.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes     = ["10.0.1.0/26"]
}


resource "azurerm_subnet" "snet03B" {
    name                 = var.snet03B 
    resource_group_name  = azurerm_resource_group.rg2.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes     = ["10.0.2.0/24"]
}


