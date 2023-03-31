variable "rg_name"{
    description = "Resource Group name"
    type        = string
}
variable "rg_location"{
    description = "Location name"
    type        = string
}
variable "backup_location"{
    description = "Location name"
    type        = string
}
variable "cosmos_db_account_name" {
    description = "Cosmos DB Account Name"
}
variable "subnet_id" {
  type = list(object({
    id   = string
  }))
}

variable "offer_type"{
    description = "offer_type"
    type        = string
}

variable "cosmos_kind"{
    description = "cosmos_kind"
    type        = string
}

variable "mongo_version"{
    description = "mongo_version"
    type        = string
}

variable "consistency_level"{
    description = "consistency_level"
    type        = string
}

variable "backup_type"{
    description = "backup_type"
    type        = string
}

variable "interval_minutes"{
    description = "interval_minutes"
    type        = string
}

variable "interval_hours"{
    description = "interval_hours"
    type        = string
}

variable "container_name"{
    description = "container_name"
    type        = string
}

variable "throughput"{
  
}

variable "is_virtual_network_filter_enabled"{
  
}

variable "enable_automatic_failover"{
  
}

variable "enable_free_tier"{
  
}

variable "cosmosdb_tags" {
   type = map(string)
}

variable "access_key_metadata_writes_enabled" {
  
}

variable "collectionname" {
  
}

variable "collectionname2" {
  
}

variable "collectionname3" {
  
}

variable "collectionname4" {
  
}
variable "collectionname5" {
  
}

variable "index1" {
  
}

variable "index2" {
  
}

variable "index3" {
  
} 

variable "index4" {
  
}

variable "index5" {
  
}

variable "index6" {
  
}

variable "index7" {
  
}

variable "index8" {
  
}

variable "index9" {
  
}
variable "index10" {
  
}

