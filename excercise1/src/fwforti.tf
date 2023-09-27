
# Creacion firewall Fortigate 
resource "azurerm_public_ip" "pip_fw" {
  name                = var.pip_fw
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tgs
}

resource "azurerm_network_interface" "nic1_fw" {
  name                                = var.nic1_fw
  location                            = var.lct
  resource_group_name                 = var.rg1
  tags                                = var.tgs 

  ip_configuration {
    name                              = "ipconfig0"
    subnet_id                         = azurerm_subnet.snet02.id
    private_ip_address_allocation     = "Dynamic"
	  public_ip_address_id              = azurerm_public_ip.pip_fw.id
  }
  enable_ip_forwarding                = "true" # added for temporary 
  enable_accelerated_networking       = "false" # "true" /* for temporary */
}

resource "azurerm_network_interface" "nic2_fw" {
  name                                = var.nic2_fw
  location                            = var.lct
  resource_group_name                 = var.rg1
  tags                                = var.tgs 

  ip_configuration {
    name                              = "ipconfig0"
    subnet_id                         = azurerm_subnet.snet01.id
    private_ip_address_allocation     = "Dynamic"
  }

  enable_ip_forwarding                = "true"
  enable_accelerated_networking       = "false" # "true" /* for temporary */
}

resource "azurerm_virtual_machine" "vmfw" {
  name                         = var.vmfw
  location                     = azurerm_resource_group.rg1.location
  resource_group_name          = azurerm_resource_group.rg1.name
  vm_size                      = "Standard_DS1_v2"
  network_interface_ids        = [azurerm_network_interface.nic1_fw.id,azurerm_network_interface.nic2_fw.id]
  primary_network_interface_id = azurerm_network_interface.nic1_fw.id
 
 
    storage_image_reference {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku       = "fortinet_fg-vm"
    version   = "7.4.0"
  }

   plan {
    name      = "fortinet_fg-vm"
    product   = "fortinet_fortigate-vm_v5"
    publisher = "fortinet"
  }
  
   storage_os_disk {
    name              = "disk_os_fw0"
    os_type           = "Linux"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = 32 
    managed_disk_type = "StandardSSD_LRS" # Cambiar tipo de disco https://learn.microsoft.com/en-us/dotnet/api/azure.resourcemanager.compute.models.storageaccounttype?view=azure-dotnet
  }

   os_profile {
    admin_username = "cwbcsc"
    admin_password = azurerm_key_vault_secret.vmpassword.value
    computer_name  = "vm"
  }

   os_profile_linux_config {
    disable_password_authentication = false
  }

}

resource "azurerm_network_security_group" "nsg_fwnic1" {
  name                = var.nsg_fwnic1
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
    security_rule {
    name                       = "Alltraficcpermit"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_assfwnic1" {
  network_interface_id      = azurerm_network_interface.nic1_fw.id
  network_security_group_id = azurerm_network_security_group.nsg_fwnic1.id
}

resource "azurerm_network_security_group" "nsg_fwnic2" {
  name                = var.nsg_fwnic2
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
resource "azurerm_network_interface_security_group_association" "nsg_assfwnic2" {
  network_interface_id      = azurerm_network_interface.nic2_fw.id
  network_security_group_id = azurerm_network_security_group.nsg_fwnic2.id
}

