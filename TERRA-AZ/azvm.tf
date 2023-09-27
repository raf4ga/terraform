resource "azurerm_windows_virtual_machine" "terravmaz" {
  name                = var.terraserver.name
  resource_group_name = azurerm_resource_group.terrarg.name
  location            = azurerm_resource_group.terrarg.location
  size                = var.terraserver.size
  admin_username      = var.terraserver.uname
  admin_password      = var.terraserver.adminpass
  network_interface_ids = [
    azurerm_network_interface.terranicaz.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.terraserver.storagetype
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    "Name" = "TERRA-SERVER"
  }
}