# Creacion de servicio: Storage Account y container(Contenedor)
resource "azurerm_storage_account" "staccount" {
  name                     = var.staccount
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tgs   
}

resource "azurerm_storage_container" "stacontainer" {
  name                  = var.stacontainer
  storage_account_name  = azurerm_storage_account.staccount.name
  container_access_type = "private"
}