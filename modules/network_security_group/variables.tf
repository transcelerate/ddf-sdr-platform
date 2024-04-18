variable nsg_name {
  
}

variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable "network_security_rules" {

    type = list(object({
        name                        = string
        priority                    = string
        direction                   = string
        access                      = string
        protocol                    = string
        source_port_range           = string
        destination_port_range      = string
        destination_port_ranges     = list(string)
        source_address_prefix       = string
        destination_address_prefix  = string
    }))
  
}