variable "keyvault_name" {
  
}

variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}

variable "enabled_for_disk_encryption" {
  
}

variable "enabled_for_template_deployment" {
  
}

variable "enabled_for_deployment" {
  
}

variable "sku_name" {
  
}

variable "soft_delete_retention_days" {
  
}

variable "purge_protection_enabled" {
  
}

variable "key_vault_tags" {
   type = map(string)
}

/* variable "soft_delete_enabled" {
  
} */