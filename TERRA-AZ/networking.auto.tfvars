terravnetrg = {
  "name"     = "TERRA-RG"
  "location" = "East US"
}

terransg = {
  "name" = "TERRA-NSG"
}

terravnetid = "10.50.0.0/16"

terravnetname = "TERRA-VNET"

terrasubnets = ["10.50.0.0/24", "10.50.1.0/24"]

terrasubnetname1 = "TERRA-PUBLIC-SUBNET1"

terrasubnetname2 = "TERRA-PUBLIC-SUBNET2"

terraip = "TerraPublicIP"

varterranic = {
  "name"       = "TERRA-NIC"
  "ipconfname" = "IPconf"
}

terraserver = {
  "name"        = "TERRA-AZVM"
  "size"        = "Standard_F2"
  "uname"       = "adminuser"
  "adminpass"   = "P@$$w0rd1234!"
  "storagetype" = "Standard_LRS"
}