resource "azurerm_resource_group" "terrarg" {
  name     = var.terravnetrg.name
  location = var.terravnetrg.location

  tags = {
    "Name" = "TERRA-RG"
  }
}

resource "azurerm_network_security_group" "terransgaz" {
  name                = var.terransg.name
  location            = azurerm_resource_group.terrarg.location
  resource_group_name = azurerm_resource_group.terrarg.name

  tags = {
    "Name" = "TERRA-NSG"
  }
}

resource "azurerm_virtual_network" "terravnet" {
  name                = var.terravnetname
  location            = azurerm_resource_group.terrarg.location
  resource_group_name = azurerm_resource_group.terrarg.name
  address_space       = [var.terravnetid]

  tags = {
    "Name" = "TERRA-VNET"
  }
}

resource "azurerm_subnet" "terrasubnet1" {
  name                 = var.terrasubnetname1
  resource_group_name  = azurerm_resource_group.terrarg.name
  virtual_network_name = azurerm_virtual_network.terravnet.name
  address_prefixes     = [var.terrasubnets[0]]
}

resource "azurerm_subnet" "terrasubnet2" {
  name                 = var.terrasubnetname2
  resource_group_name  = azurerm_resource_group.terrarg.name
  virtual_network_name = azurerm_virtual_network.terravnet.name
  address_prefixes     = [var.terrasubnets[1]]
}

resource "azurerm_subnet_network_security_group_association" "nsgtosubnet" {
  subnet_id                 = azurerm_subnet.terrasubnet1.id
  network_security_group_id = azurerm_network_security_group.terransgaz.id
}

resource "azurerm_public_ip" "terraipp" {
  name                = var.terraip
  resource_group_name = azurerm_resource_group.terrarg.name
  location            = azurerm_resource_group.terrarg.location
  allocation_method   = "Dynamic"

  tags = {
    "Name" = "TERRA-PUBLIC"
  }
}

resource "azurerm_network_interface" "terranicaz" {
  name                = var.varterranic.name
  location            = azurerm_resource_group.terrarg.location
  resource_group_name = azurerm_resource_group.terrarg.name

  ip_configuration {
    name                          = var.varterranic.ipconfname
    subnet_id                     = azurerm_subnet.terrasubnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terraipp.id
  }
}

resource "azurerm_network_security_rule" "example" {
  name                        = "RDPCONNECTION"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.terrarg.name
  network_security_group_name = azurerm_network_security_group.terransgaz.name

}