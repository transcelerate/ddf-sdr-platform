variable "rg_name"{
    description = "Resource Group name"
    type        = string
}

variable "storage_account_name" {
  description = "name of the storage account"

}

variable "storage_location" {

  description = "Storage Location"
  
}
variable "storage_account_type" {
  description = "Storage account type for storage like Standard_LRS"

}

variable "storage_account_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}


variable "storage_account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  
}

variable "storage_account_access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."

}

variable "secure_transfer" {
  
}

variable "enable_blob_public_access" {
  
}

variable "storage_account_key_access" {
  
}

variable "tls_version" {
  
}
variable "enable_hierarchical_namespace" {
  
}
variable "enable_network_file_system_v3" {
  
}
variable "large_file_share_enabled" {
  
}

variable "virtual_network_subnet_ids" {
  type = list(string)
}

variable "default_action" {
  
}

variable "enable_publish_microsoft_endpoints" {
  
}

variable "retention_days" {
  
}
variable "versioning_enabled" {
  
}

variable "change_feed_enabled" {
  
}

