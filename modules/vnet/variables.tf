variable "vnet_name"{

}
variable "address_space"{
   type = list(string)
}
variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable "vnet_tags" {

   type = map(string)
  
}
