variable "subnet_name"{

}
variable "address_prefix"{
   type = list(string) 
}
variable "vnet_name"{
    
}
variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable "subnet_depends_on" {
  
  type    = any
  default = []
}

variable "service_endpoints" {
  
  type = list(string)
  
}