resource "azurerm_route_table" "routetable" {
  name                = var.routetable
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs

  route {
    name                   = "rt-fwftg"
    address_prefix         = "10.0.1.0/26"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.1.4"
  }
}

resource "azurerm_subnet_route_table_association" "assroutable" {
  subnet_id      = azurerm_subnet.snet03.id
  route_table_id = azurerm_route_table.routetable.id
}