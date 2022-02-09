
variable "key_vault_id" {
  
}

variable "tenant_id" {
  
}

variable "object_id" {
  
}

variable "key_permissions" {

    type = list(string)
  
}

variable "secret_permissions" {
  
  type = list(string)

}

variable "certificate_permissions" {

    type = list(string)
  
}


