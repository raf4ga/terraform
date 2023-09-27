variable "terravnetrg" {
  description = "Parametros para Grupo de Recurso"
  type        = map(string)
}

variable "terransg" {
  description = "Parametros del Network Security Group"
  type        = map(string)
}

variable "terravnetid" {
  description = "Segmento de red de la VNET"
  type        = string
}

variable "terravnetname" {
  description = "Nombre de la Vnet"
  type        = string
}

variable "terrasubnets" {
  description = "Lista de Subredes"
  type        = list(string)
}

variable "terrasubnetname1" {
  description = "Nombre de la primera subred"
  type        = string
}

variable "terrasubnetname2" {
  description = "Nombre de la segunda subred"
  type        = string
}

variable "terraip" {
  description = "Parametros de la IP Publica"
  type        = string
}

variable "varterranic" {
  description = "Propiedades de la NIC"
  type        = map(string)
}

variable "terraserver" {
  description = "Parametros de AzureVM"
  type        = map(string)
}