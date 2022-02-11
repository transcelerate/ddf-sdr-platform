####################### Variables Begin #####################################################
variable "alias_name"{
    default = "providerblock"
}
variable "env_acronym" {

    default = "#{Env-RBac}#"
  
}

variable "fe_acronym" {

    default = "ui"
  
}

variable "be_acronym" {

    default = "api"
  
}

variable "location" {

    default = "eastus"
  
}

variable "App_Layer_FE" {

    default = "Frontend"
  
}

variable "App_Layer_BE" {
  
    default = "Backend"
    
}

variable "App_Layer_NA" {
  
    default = "N/A"
    
}

variable "subscription_acronym"{
    default = "sdr"
}

variable enable_log {
    default = true 
}
variable disable_log {
    default = false
    
}


####################### Vnet Begin #####################################################

variable "address_space"{
    default = [ "#{Vnet-IP}#" ]
}

####################### Vnet End #####################################################



####################### Subnet Begin #####################################################

variable "address_prefix"{
    default = [ "#{Subnet-IP}#" ]
}

####################### Subnet End   #####################################################

####################### Delegated Subnet 1 Variable Begin   #####################################################

variable "dsaddress_prefix" {

    default = ["#{Subnet-Dsaddress1}#"]
  
}

variable "service_delegation" {

    default = "Microsoft.Web/serverFarms"
  
}

variable "service_endpoints" {

    default = ["Microsoft.Web"]
  
}

variable "delegation_name" {
  default = "deligation"
}

####################### Delegated Subnet 1 Variable End     #####################################################

####################### Delegated Subnet 2 Variable Begin   #####################################################

variable "dsaddress_prefix2" {

    default = ["#{Subnet-Dsaddress}#"]
  
}


variable "service_endpoints2" {

    default = ["Microsoft.AzureCosmosDB","Microsoft.Storage","Microsoft.Web"]
  
}

####################### Delegated Subnet 2 Variable Begin   #####################################################



####################### Storage Account Begin #####################################################

variable "storage_account_type"{
    default = "Standard_GRS"
}
variable "storage_account_kind"{
    default = "StorageV2"
}
variable "storage_account_access_tier"{
    default = "Hot"
}

variable "storage_location" {

    default = "eastus"
  
}


variable "secure_transfer" {

    default = "true"
  
}

variable "enable_blob_public_access" {

    default = "false"
  
}
variable "storage_account_key_access" {

    default = "true"
  
}

variable "tls_version" {

    default = "TLS1_2"
  
}
variable "enable_hierarchical_namespace" {

    default = "false"
  
}
variable "enable_network_file_system_v3" {

    default = "false"
  
} 
variable "large_file_share_enabled" {

    default = "false"
  
}

variable "default_action" {

    default = "Deny"
  
}
variable "retention_days"{
       default = "7"
}


variable "enable_publish_microsoft_endpoints" {

    default = "true"
  
}
variable "versioning_enabled" {

    default = "false"
  
}

variable "change_feed_enabled" {

    default = "false"
  
}


####################### Storage Account End   #####################################################




####################### Resource Group Begin #####################################################


variable "rg_location"{
    default = "eastus"
}


####################### Resource Group End #####################################################


######################API Management Variables Begin #############################################

variable "publisher_name"{
    default     = "Transcelerate-Test"
}
variable "publisher_email"{
    default     = "#{Publisher-Email}#"
}

variable "sku_name_api"{
    default     = "Developer_1"
}


variable "virtual_network_type" {

    default = "External"
  
}

variable "enable_http2" {

    default = "false"
  
}

variable "enable_backend_ssl30" {

    default = "false"
  
}

variable "enable_backend_tls10" {

    default = "false"
  
}

variable "enable_backend_tls11" {

    default = "false"
  
}

variable "enable_frontend_ssl30" {

    default = "false"
  
}

variable "enable_frontend_tls10" {

    default = "false"
  
}

variable "enable_frontend_tls11" {

    default = "false"
  
}

variable "enable_triple_des_ciphers" {

    default = "false"
  
}

variable "apimanagement_log" {

    default = "apimlog"
  
}

variable "identity_type" {
  default = "SystemAssigned"
}

######################API Management Variables End #############################################


######################APP Insights Begin ###################################################

variable "application_type" {
  default = "web"
}

######################APP Insights End    ###################################################


######################APP Service Begin  ###################################################
variable "runtime_stack" {

    default     = "node|14-lts"
}

variable "https_only" {

    default = "true"
  
}

variable "ftps_state" {

    default = "Disabled"
  
}

variable "runtime_stack2" {

    default = "DOTNETCORE|3.1"
  
}

variable "use_32_bit_worker_process" {
  default = "true"
}

variable "identity" {

    default = "SystemAssigned"
  
}

variable "http2_enabled" {

    default = "true"
  
}

variable "ip_address" {

    default = "0.0.0.0/0"
}

variable "apparname" {

    default = "AllowAll"
  
}

variable "priority" {


    default = "100"
  
}

variable "action" {

    default = "Allow"
  
}

variable "ip_address2" {
   
   default = null

}

variable "apparname2" {

    default = "AllowVnetTraffic"
  
}

variable "priority2" {

    default = "100"
  
}

variable "action2" {

    default = "Allow"
  
}


######################APP Service End  ###################################################


######################APP Service Plan Begin  ###################################################

variable "app_service_plan_os"{
    default        = "Windows"
}

variable "app_service_tier" {

    default = "Standard"
  
}

variable "app_service_size" {

    default = "S1"
  
}


######################APP Service Plan End  ###################################################

###################### Cosmos DB Start  ########################################################

variable "offer_type" {
  default = "Standard"
}

variable "cosmos_kind" {
  default = "MongoDB"
}

variable "mongo_version" {
  default = "4.0"
}
variable "consistency_level" {
  default = "Session"
}
variable "backup_type" {
  default = "Periodic"
}
variable "interval_minutes" {
  default = "1440"
}
variable "interval_hours" {
  default = "48"
}
variable "container_name" {
  default = "test-cosmos-mongo-db"
}
variable "throughput" {
  default = "400"
}

variable "backup_location" {
  default = "eastus"
}

variable "is_virtual_network_filter_enabled" {
  default = "true"
}

variable "enable_automatic_failover" {
  default = "false"
}

variable "enable_free_tier" {
  default = "false"
}

variable "access_key_metadata_writes_enabled" {

    default = "false"
}


###################### Cosmos DB End  ########################################################

###################### Key Vault Begin ########################################################


variable "sku_name"{

    default = "standard"

}

variable "enabled_for_disk_encryption"{

    default = "false"

}

variable "enabled_for_template_deployment"{

    default = "true"

}

variable "enabled_for_deployment"{

    default = "false"

}

variable "purge_protection_enabled"{

    default = "true"

}

variable "soft_delete_enabled" {

    default = "true"
}

variable "soft_delete_retention_days"{

    default = "90"

}

###################### Key Vault End ########################################################

###################### Log Analytics Workspace Begin ########################################################

variable "log_analytics_sku" {
  
  default = "PerGB2018"
}

variable "log_analytics_retention" {
  
  default = "30"
}

###################### Log Analytics Workspace End ########################################################

###################### RBAC roles variables Begin  ###################################################

variable "cosmosdb_role" {
  
  default = "DocumentDB Account Contributor"
}

variable "apim_role" {

    default = "Managed Application Operator Role"
  
}

variable "appservice1_role" {

    default = "Managed Application Operator Role"
  
}

variable "appservice2_role" {

    default = "Managed Application Operator Role"
  
}

variable "group1" {

    default = "TRAN_AZ_sub_SDR_DDFEng_Admin"

  }

variable "group2" {
  
    default = "TRAN_AZ_sub_SDR_DDFEng"
}

variable "group3" {
  
  default = "TRAN_AZ_sub_SDR_Test"
}

variable "role1" {
   
   default = "Contributor"
}

variable "role2" {

    default = "Reader"
  
}

###################### RBAC roles variables End  ###################################################

