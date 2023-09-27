# Creacion de variable Cliente Secret 
variable "client_secret" {
type = string
 }

# Creacion de grupo de recursos # 1
variable "rg1" {
type = string
 }

 # Creacion de grupo de recursos # 1
variable "rg2" {
type = string
 }

# Creacion de location #1 
variable "lct" {
type = string
 }

 # Creacion de location #2 
variable "lct1" {
type = string
 }

# Creacion de tags en Azure 
variable "tgs" {
type = map(string)
 }

# Creacion Vnet
variable "vnet1" {
type = string
 }

# Creacion de Subnet 1
 variable "snet01" {
type = string
 }

 # Creacion de Subnet 2
 variable "snet02" {
type = string
 }

 # Creacion de Subnet 3
 variable "snet03" {
type = string
 }

# Creacion Ip publica VM Windows Server 
variable "pipvm" {
type = string
 }

 # Creacion de nic #1 para VM Windows server  
variable "nic_win" {
type = string
 }

 # Creacion de nic #2 para VM Windows server  
variable "nic_win1" {
type = string
 }

# Creacion de VM Windows server
variable "vmwin" {
type = string
 }

 # Creacion de network security group #1
variable "nsg_win" {
type = string
 }

  # Creacion de network security group #1
variable "nsg_win1" {
type = string
 }

# Creacion de network security group association #1
variable "nsg_asswin" {
type = string
 }

 # Creacion de network security group association # 2
variable "nsg_asswin1" {
type = string
 }

 
# Creacion de variable de disco nuevo 
variable "data_disk" {
type = string
 }

 # Creacion de variable de disco de datos atachado 
variable "diskatach" {
type = string
 }

 
 # Creacion de variable keyvault 
variable "key_vault" {
type = string
 }

# Creacion de variable secreto de keyvault 
variable "vmpassword" {
type = string
 }

 # Variable de Ip publica de Linux  
variable "pipvmlin" {
type = string
 }

# Variable de nic de linux  
variable "nic_lin" {
type = string
 }

 # Variable para creacion de maquina virtual linux   
variable "vmlinux" {
type = string
 }

 
# Variable creacion nsg vm linux 
variable "nsg_lin" {
type = string
 }

 # Variable creacion variable de associacion nsg linux
variable "nsg_asslin" {
type = string
 }

# Variable creacion storage account o cuenta de almacenamiento
variable "staccount" {
type = string
 }

 # Variable creacion container en storage account
variable "stacontainer" {
type = string
 }

 ##### recursos firewall Fortigate 


# Variable ip publica firewall
variable "pip_fw" {
type = string
 }

 # Variable nic 1 de firewall 
variable "nic1_fw" {
type = string
 }

 # Variable nic 1 de firewall 
variable "nic2_fw" {
type = string
 }

# Variable creacion de vm firewall
variable "vmfw" {
type = string
 }

 # Variable creacion nsg de nic 1
variable "nsg_fwnic1" {
type = string
 }
  
  # Variable creacion asociacion de nsg
variable "nsg_assfwnic1" {
type = string
 }

  # Variable creacion nsg de nic 2
variable "nsg_fwnic2" {
type = string
 }

  # Variable creacion asociacion de nsg
variable "nsg_assfwnic2" {
type = string
 }

 ## Variables configuracion de recovery Services Vault 

# Variable creacion servicio recovery services vault
variable "rsv1" {
type = string
 }

 # Variable creacion site recovery fabric - Primary
variable "primary" {
type = string
 }

  # Variable creacion site recovery fabric - Secondary
variable "secondary" {
type = string
 }

  # Variable creacion azure site recovery proyection container - Primary
variable "asrpc_prim" {
type = string
 }

   # Variable creacion azure site recovery proyection container - Secondary
variable "asrpc_secon" {
type = string
 }

   # Variable creacion azure site recovery replication policy
variable "asrp_pol" {
type = string
 }

# Variable creacion azure site recovery protection container mapping
variable "asrpcm" {
type = string
 }

 # Variable creacion azure site recovery network mapping 
variable "asrnm" {
type = string
 }

 # Creacion Vnet Zona B
variable "vnet2" {
type = string
 }

# Creacion de Subnet 1 - Zona B
 variable "snet01B" {
type = string
 }

 # Creacion de Subnet 2 - Zona B
 variable "snet02B" {
type = string
 }

 # Creacion de Subnet 3 - Zona B
 variable "snet03B" {
type = string
 }

# Creacion de storage account de azure site recovery
 variable "stacacheasr" {
type = string
 }

 # Creacion de replica azure site recovery 
 variable "asreplvm" {
type = string
 }

  # Variable de Route table
 variable "routetable" {
type = string
 }

 # Variable de associacion de Route table
 variable "assroutable" {
type = string
 }





