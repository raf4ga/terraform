# variable y valor Client Secret

client_secret    = "tYq8Q~6C_kp3sleWCLMAEbyUmibMa65a8FKeOatD"

# Variables y valores grupo de recursos,location y tags 

rg1              = "rg-rubis-regionA"
rg2              = "rg-rubis-regionB"
lct              = "eastus"
lct1             = "westus"
tgs              = {
  enviroment     = "test"
  implementador  = "Shaim Mendez"
  Request        = "XXXX"
}

# Variables y valores vnets y subnet 

vnet1            = "vnet-rubis-RA"
snet01           = "snet-internal-RA"
snet02           = "snet-external-RA"
snet03           = "snet-protected-RA"
vnet2            = "vnet-rubis-RB"
snet01B          = "snet-internal-RB"
snet02B          = "snet-external-RB"
snet03B          = "snet-protected-RB"

# Variables y valores de Maquina virtual Windows Server 

pipvm            = "pip-vmwin"
nic_win          = "nic-win1"
nic_win1         = "nic-win2" 
vmwin            = "vmwin"
nsg_win          = "nsg_win1" 
nsg_win1         = "nsg_win2"
nsg_asswin       = "nsg_asswin1"
nsg_asswin1      = "nsg_asswin2"
data_disk        = "data_disk"
diskatach        = "diskatach"

# Variables y valores de Keyvault 
key_vault        = "kvault-rubis" 
vmpassword       = "secret-vmpass"

# Variables y valores de Maquina virtual Linux

pipvmlin         = "pip-vmlin"
nic_lin          = "nic_lin1"
vmlinux          = "vmlinux" 
nsg_lin          = "nsg_lin1"
nsg_asslin       = "nsg_asslin"  

# Variables y valores de storage account

staccount        = "starubis"
stacontainer     = "stacontainer01"   

# Variables y valores de maquina virtual Firewall fortigate

pip_fw           = "pip_vmfw"
nic1_fw          = "nic1_fw1"
nic2_fw          = "nic2_fw2"
vmfw             = "vmfwftg"
nsg_fwnic1       = "nsg_fwnic1"
nsg_assfwnic1    = "nsg_assfwnic1"
nsg_fwnic2       = "nsg_fwnic2"
nsg_assfwnic2    = "nsg_assfwnic2" 

# Variables y valores de rescovery service vault

rsv1             = "rsvasrrubis"
primary          = "primary"
secondary        = "secondary"
asrpc_prim       = "asrpc_prim"
asrpc_secon      = "asrpc_secon"
asrp_pol         = "asr_policy"
asrpcm           = "asr_pcm"
asrnm            = "asr_netmap"
stacacheasr      = "stacacheasr"
asreplvm         = "asr_replvm" 

# Variables y valores de route table

routetable       = "rt_fw01"
assroutable      = "assroutable"








