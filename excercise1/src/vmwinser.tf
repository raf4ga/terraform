
# Creacion de virtual machine Windows Server 2022

# Create public IPs
resource "azurerm_public_ip" "pipvm" {
  name                = var.pipvm
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tgs
}

# Create network interface # 1 a la IP publica 
resource "azurerm_network_interface" "nic_win" {
  name                = var.nic_win
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs

  ip_configuration {
    name                          = "ipconfig0"
    subnet_id                     =  azurerm_subnet.snet03.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  azurerm_public_ip.pipvm.id
    primary                       = "true"
  }
}
  

# Create network interface # 2 a la ip privada 
resource "azurerm_network_interface" "nic_win1" {
  name                = var.nic_win1
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     =  azurerm_subnet.snet03.id
    private_ip_address_allocation = "Dynamic"
    primary                       = "true"
  }
}


resource "azurerm_virtual_machine" "vmwin" {
  name                         = var.vmwin
  resource_group_name          = azurerm_resource_group.rg1.name
  location                     = azurerm_resource_group.rg1.location
  vm_size                      = "Standard_B2ms"
  network_interface_ids        = [azurerm_network_interface.nic_win.id,azurerm_network_interface.nic_win1.id] # Linea para agregar una o mas interfaces de red 
  tags                         = var.tgs 
  primary_network_interface_id = azurerm_network_interface.nic_win.id
   storage_os_disk {
    name              = "win_os_disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS" # cambiar tipo de disco https://learn.microsoft.com/en-us/dotnet/api/azure.resourcemanager.compute.models.storageaccounttype?view=azure-dotnet
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  os_profile {
    computer_name  = var.vmwin
    admin_username = "cwbcsc"
    admin_password = azurerm_key_vault_secret.vmpassword.value
  }
    os_profile_windows_config {   # Cambiar  os_profile_linux_config si la maquina es Linux
    provision_vm_agent  = true          
  }
}

# Crear un nuevo disco duro en maquina virtual "azurerm_managed_disk" "data_disk" y "azurerm_virtual_machine_data_disk_attachment"
 /*
  resource "azurerm_managed_disk" "data_disk" {
  name                 = var.data_disk
  location             = azurerm_resource_group.rg1.location
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_type = "StandardSSD_LRS" # Cambiar tipo de disco https://learn.microsoft.com/en-us/dotnet/api/azure.resourcemanager.compute.models.storageaccounttype?view=azure-dotnet
  create_option        = "Empty"
  disk_size_gb         = 50  # cambiar tamaño disco  
  tags                = var.tgs
}

 resource "azurerm_virtual_machine_data_disk_attachment" "diskatach" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vmwin.id 
  lun                = "0"
  caching            = "ReadWrite"
}
*/

# Create Network Security Group and rule windows
resource "azurerm_network_security_group" "nsg_win" {
  name                = var.nsg_win
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs

  security_rule {
    name                       = "RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface #1
resource "azurerm_network_interface_security_group_association" "nsg_asswin" {
  network_interface_id      = azurerm_network_interface.nic_win.id
  network_security_group_id = azurerm_network_security_group.nsg_win.id
}

# Create Network Security Group and rule windows
resource "azurerm_network_security_group" "nsg_win1" {
  name                = var.nsg_win1
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.tgs
  security_rule {
    name                       = "RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_asswin1" {
  network_interface_id      = azurerm_network_interface.nic_win1.id
  network_security_group_id = azurerm_network_security_group.nsg_win1.id
}
