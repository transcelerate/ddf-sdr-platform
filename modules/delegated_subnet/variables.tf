variable "subnet_name" {
  
}

variable "vnet_name" {
  
}
variable "address_prefix" {
  
}

variable "rg_name"{
    description = "Resource Group name"
    type        = string
}

variable "service_delegation" {
  
}

variable "service_endpoints" {

    type = list(string)
  
}

variable "delegated_subnet_depends_on" {
  
  type    = any
  default = []
}

variable "delegation_name" {
  
}
