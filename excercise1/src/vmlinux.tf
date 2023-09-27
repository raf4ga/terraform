# Creacion de Maquina Virtual Linux Debian

# Create IP publica de linux
resource "azurerm_public_ip" "pipvmlin" {
  name                = var.pipvmlin
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tgs
}

# Create network interface
resource "azurerm_network_interface" "nic_lin" {
  name                = var.nic_lin
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs

  ip_configuration {
    name                          = "nic_configuration"
    subnet_id                     =  azurerm_subnet.snet03.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  azurerm_public_ip.pipvmlin.id
  }
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  name                              = var.vmlinux
  location                          = azurerm_resource_group.rg1.location
  resource_group_name               = azurerm_resource_group.rg1.name
  size                              = "Standard_B2s"
  network_interface_ids             = [azurerm_network_interface.nic_lin.id]
  admin_username                    = "cwbcsc"
  admin_password                    = azurerm_key_vault_secret.vmpassword.value
  disable_password_authentication   = false
  tags                              = var.tgs
  source_image_reference {
    offer     = "debian-11"
    publisher = "debian"
    sku       = "11"
    version   = "latest"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }
}

# Crear un nuevo disco duro en maquina virtual "azurerm_managed_disk" "data_disk" y "azurerm_virtual_machine_data_disk_attachment"
/*  
 Resource "azurerm_managed_disk" "data_disk" {
  name                 = var.data_disk
  location             = azurerm_resource_group.rg1.location
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_type = "StandardSSD_LRS" # Cambiar tipo de disco https://learn.microsoft.com/en-us/dotnet/api/azure.resourcemanager.compute.models.storageaccounttype?view=azure-dotnet
  create_option        = "Empty"
  disk_size_gb         = 50  # cambiar tamaño 
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskatach" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vmwin.id 
  lun                = "0"
  caching            = "ReadWrite"
}
*/

resource "azurerm_network_security_group" "nsg_lin" {
  name                = var.nsg_lin
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_asslin" {
  network_interface_id      = azurerm_network_interface.nic_lin.id
  network_security_group_id = azurerm_network_security_group.nsg_lin.id
}
