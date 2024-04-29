####################### Variables Begin #####################################################
variable "alias_name"{
    default = "providerblock"
}

variable "client_id"{
    default = "#{Client-ID}#"
}

variable "client_secret"{
    default = "#{Client-Secret}#"
}

variable "tenant_id"{
    default = "#{Tenant-ID}#"
}

variable "env_acronym" {

    default = "#{Env}#"
  
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
    default = "#{subscription}#"
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

variable "sub_service_endpoints" {

    default = ["Microsoft.Web","Microsoft.KeyVault","Microsoft.Storage"]
  
}

####################### Subnet End   #####################################################

####################### Public IP Begin #####################################################
variable pip_allocation_method {
    default = "Static"
}
variable pip_sku {
    default = "Standard"
}
variable pip_protection_mode {
    default = "Enabled"
}

variable "public_ip_zones" {

    default = ["2","1","3"]
  
}
####################### Public IP End #####################################################


####################### Network Security Rules - Begin #############################################

variable "network_security_rules" {

    default = [
    {
        name                        = "AllowTagCustom3443Inbound"
        priority                    = "100"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "3443"
        source_address_prefix       = "ApiManagement"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowTagCustom443Inbound"
        priority                    = "110"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "Internet"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowTagCustom6390Inbound"
        priority                    = "120"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "6390"
        source_address_prefix       = "AzureLoadBalancer"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowTagCustom443Inbound-ATM"
        priority                    = "130"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "AzureTrafficManager"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowTagCustom443Outbound"
        priority                    = "100"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "Storage"
    },
    {
        name                        = "AllowTagCustom443Outbound-App"
        priority                    = "110"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowTagCustom1443Outbound"
        priority                    = "120"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "1433"
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "Sql"
    },
    {
        name                        = "AllowTagCustom443Outbound-KV"
        priority                    = "130"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "AzureKeyVault"
    },
    {
        name                        = "AllowAnyCustom433Outbound"
        priority                    = "150"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    },
    {
        name                        = "DenyAnyCustomOutbound"
        priority                    = "4096"
        direction                   = "Outbound"
        access                      = "Deny"
        protocol                    = "*"
        source_port_range           = "*"
        destination_port_range      = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }
    ]
}

variable "network_security_rules_multiport" {

    default = [
        {
        name                        = "AllowTagCustom1886-443Outbound"
        priority                    = "140"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_ranges     = ["1886","443"]
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "AzureMonitor"
    }
    ]
}


####################### Network Security Rules - End ##################################################

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

    default = ["#{Subnet-Dsaddress2}#"]
  
}


variable "service_endpoints2" {

    default = ["Microsoft.AzureCosmosDB","Microsoft.Storage","Microsoft.Web"]
  
}

####################### Delegated Subnet 2 Variable Begin   #####################################################

####################### Delegated Subnet 3 Variable Begin   #####################################################

variable "dsaddress_prefix3" {

    default = ["#{Subnet-Dsaddress3}#"]
  
}

####################### Delegated Subnet 3 Variable Begin   #####################################################

####################### Resource Group Begin #####################################################


variable "rg_location"{
    default = "eastus"
}


####################### Resource Group End #####################################################


######################API Management Variables Begin #############################################

variable "publisher_name"{
    default     = "#{Publisher-Name}#"
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

/* variable "enable_triple_des_ciphers" {

    default = "false"
  
} */

variable "apimanagement_log" {

    default = "apimlog"
  
}

variable "identity_type" {
  default = "SystemAssigned"
}

variable "apiendpoints" {

    default = [
    {
        name         = "sdr-api"
        display_name = "SDR API"
        path         = "api"  
    },
    {
        name         = "sdr-ui-admin"
        display_name = "SDR UI Admin"
        path         = "api/ui/admin"
    },
    {
        name         = "sdr-ui-api"
        display_name = "SDR UI API"
        path         = "api/ui"
    }]
}

variable "apioperations" {

    default = [
    {
        operation_id = "common-get-api-versions"
        api_name     = "sdr-api"
        display_name = "Common - Get API Versions"
        method       = "GET"
        url_template = "/versions"
    },
    {
        operation_id = "common-get-study-history"
        api_name     = "sdr-api"
        display_name = "Common - Get Study History"
        method       = "GET"
        url_template = "/studydefinitions/history"
    },
	{
        operation_id = "check-group-name"
        api_name     = "sdr-ui-admin"
        display_name = "Check Group Name"
        method       = "GET"
        url_template = "/usergroups/checkgroupname"
    },
    {
        operation_id = "get-group-list"
        api_name     = "sdr-ui-admin"
        display_name = "Get Group List"
        method       = "GET"
        url_template = "/usergroups/getgrouplist"
    },
    {
        operation_id = "get-groups"
        api_name     = "sdr-ui-admin"
        display_name = "Get Groups"
        method       = "POST"
        url_template = "/usergroups/getgroups"
    },
    {
        operation_id = "get-users"
        api_name     = "sdr-ui-admin"
        display_name = "Get Users"
        method       = "POST"
        url_template = "/usergroups/getusers"
    },
    {
        operation_id = "list-users"
        api_name     = "sdr-ui-admin"
        display_name = "List Users"
        method       = "GET"
        url_template = "/usergroups/listusers"
    },
    {
        operation_id = "post-group"
        api_name     = "sdr-ui-admin"
        display_name = "Post Group"
        method       = "POST"
        url_template = "/usergroups/postgroup"
    },
    {
        operation_id = "post-user"
        api_name     = "sdr-ui-admin"
        display_name = "Post User"
        method       = "POST"
        url_template = "/usergroups/postuser"
    },
    {
        operation_id = "search-api"
        api_name     = "sdr-ui-api"
        display_name = "Search API"
        method       = "POST"
        url_template = "/studydefinitions/search"
    },
    {
        operation_id = "search-study-title"
        api_name     = "sdr-ui-api"
        display_name = "Search Study Title"
        method       = "POST"
        url_template = "/studydefinitions/searchstudytitle"
    },
    {
        operation_id = "usage-reports"
        api_name     = "sdr-ui-api"
        display_name = "Usage Reports"
        method       = "POST"
        url_template = "/reports/usage"
    },
    {
        operation_id = "common-get-api-versions-sdruiapi"
        api_name     = "sdr-ui-api"
        display_name = "Common - Get API Versions"
        method       = "GET"
        url_template = "/versions"
    },
    {
        operation_id = "v2-get-study-design"
        api_name     = "sdr-api"
        display_name = "V2 Get Study Design"
        method       = "GET"
        url_template = "/v2/studydesigns"
    },
    {
        operation_id = "v2-post-study-definition"
        api_name     = "sdr-api"
        display_name = "V2 Post Study Definition"
        method       = "POST"
        url_template = "/v2/studydefinitions"
    },
     {
        operation_id = "v3-get-study-design"
        api_name     = "sdr-api"
        display_name = "V3 Get Study Design"
        method       = "GET"
        url_template = "/v3/studydesigns"
    },
    {
        operation_id = "v3-post-study-definition"
        api_name     = "sdr-api"
        display_name = "V3 Post Study Definition"
        method       = "POST"
        url_template = "/v3/studydefinitions"
    },
    {
        operation_id = "v3-validate-usdm-conformance"
        api_name     = "sdr-api"
        display_name = "V3 Validate USDM Conformance"
        method       = "POST"
        url_template = "/v3/studydefinitions/validate-usdm-conformance"
    },
	{
        operation_id = "v4-get-study-design"
        api_name     = "sdr-api"
        display_name = "V4 Get Study Design"
        method       = "GET"
        url_template = "/v4/studydesigns"
    },
    {
        operation_id = "v4-post-study-definition"
        api_name     = "sdr-api"
        display_name = "V4 Post Study Definition"
        method       = "POST"
        url_template = "/v4/studydefinitions"
    },
    {
        operation_id = "v4-validate-usdm-conformance"
        api_name     = "sdr-api"
        display_name = "V4 Validate USDM Conformance"
        method       = "POST"
        url_template = "/v4/studydefinitions/validate-usdm-conformance"
    }
    ]
  
}

variable "apioperations_tp" {

    default = [
    {
        operation_id = "common-delete-study-definition"
        api_name     = "sdr-api"   
        display_name = "Common - Delete Study Definition"
        method       = "DELETE"
        url_template = "/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "common-get-revision-history"
        api_name     = "sdr-api"   
        display_name = "Common - Get Revision History"
        method       = "GET"
        url_template = "/studydefinitions/{studyId}/revisionhistory"
        tempname     = "studyId"
    },
    {
        operation_id = "common-get-change-audit"
        api_name     = "sdr-api"   
        display_name = "Common - Get Change Audit"
        method       = "GET"
        url_template = "/studydefinitions/{studyId}/changeaudit"
        tempname     = "studyId"
    },
	{
        operation_id = "common-get-study-raw-data"
        api_name     = "sdr-api"   
        display_name = "Common - Get Study Raw Data"
        method       = "GET"
        url_template = "/studydefinitions/{studyId}/rawdata"
        tempname     = "studyId"
    },
	{
        operation_id = "common-get-revision-history-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "Common - Get Revision History"
        method       = "GET"
        url_template = "/studydefinitions/{studyId}/revisionhistory"
        tempname     = "studyId"
    },
    {
        operation_id = "get-study-links"
        api_name     = "sdr-ui-api"   
        display_name = "Get Study Links"
        method       = "GET"
        url_template = "/studydefinitions/{studyId}/links"
        tempname     = "studyId"
    },
    {
        operation_id = "v2-get-study-design-soa"
        api_name     = "sdr-api"   
        display_name = "V2 Get Study Design SOA"
        method       = "GET"
        url_template = "/v2/studydefinitions/{studyId}/studydesigns/soa"
        tempname     = "studyId"
    },
	{
        operation_id = "v2-get-study-design-soa-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "V2 Get Study Design SOA"
        method       = "GET"
        url_template = "/v2/studydefinitions/{studyId}/studydesigns/soa"
        tempname     = "studyId"
    },
    {
        operation_id = "v2-get-ecpt"
        api_name     = "sdr-api"
        display_name = "V2 Get eCPT"
        method       = "GET"
        url_template = "/v2/studyDefinitions/{studyId}/studydesigns/ecpt"
        tempname     = "studyId"
    },
    {
        operation_id = "v2-get-study-definition"
        api_name     = "sdr-api"   
        display_name = "V2 Get Study Definition"
        method       = "GET"
        url_template = "/v2/studydefinitions/{studyid}"
        tempname     = "studyId"
    },
    {
        operation_id = "v2-put-study-definitions"
        api_name     = "sdr-api"
        display_name = "V2 Put Study Definitions"
        method       = "PUT"
        url_template = "/v2/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v2-get-study-definition-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "V2 Get Study Definition"
        method       = "GET"
        url_template = "/v2/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-get-study-design-soa-sdrapi"
        api_name     = "sdr-api"   
        display_name = "V3 Get Study Design SOA"
        method       = "GET"
        url_template = "/v3/studydefinitions/{studyId}/studydesigns/soa"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-get-study-design-soa-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "V3 Get Study Design SOA"
        method       = "GET"
        url_template = "/v3/studydefinitions/{studyId}/studydesigns/soa"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-get-ecpt"
        api_name     = "sdr-api"
        display_name = "V3 Get eCPT"
        method       = "GET"
        url_template = "/v3/studyDefinitions/{studyId}/studydesigns/ecpt"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-get-study-definition-sdrapi"
        api_name     = "sdr-api"   
        display_name = "V3 Get Study Definition"
        method       = "GET"
        url_template = "/v3/studydefinitions/{studyid}"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-put-study-definitions"
        api_name     = "sdr-api"
        display_name = "V3 Put Study Definitions"
        method       = "PUT"
        url_template = "/v3/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-get-study-definition-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "V3 Get Study Definition"
        method       = "GET"
        url_template = "/v3/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v3-version-comparison"
        api_name     = "sdr-api"   
        display_name = "V3 Version Comparison "
        method       = "GET"
        url_template = "/v3/studydefinitions/{studyId}/version-comparison"
        tempname     = "studyId"
    },
	{
        operation_id = "v4-get-study-design-soa-sdrapi"
        api_name     = "sdr-api"   
        display_name = "V4 Get Study Design SOA"
        method       = "GET"
        url_template = "/v4/studydefinitions/{studyId}/studydesigns/soa"
        tempname     = "studyId"
    },
    {
        operation_id = "v4-get-study-design-soa-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "V4 Get Study Design SOA"
        method       = "GET"
        url_template = "/v4/studydefinitions/{studyId}/studydesigns/soa"
        tempname     = "studyId"
    },
    {
        operation_id = "v4-get-ecpt"
        api_name     = "sdr-api"
        display_name = "V4 Get eCPT"
        method       = "GET"
        url_template = "/v4/studyDefinitions/{studyId}/studydesigns/ecpt"
        tempname     = "studyId"
    },
    {
        operation_id = "v4-get-study-definition-sdrapi"
        api_name     = "sdr-api"   
        display_name = "V4 Get Study Definition"
        method       = "GET"
        url_template = "/v4/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v4-put-study-definitions"
        api_name     = "sdr-api"
        display_name = "V4 Put Study Definitions"
        method       = "PUT"
        url_template = "/v4/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v4-get-study-definition-sdruiapi"
        api_name     = "sdr-ui-api"   
        display_name = "V4 Get Study Definition"
        method       = "GET"
        url_template = "/v4/studydefinitions/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "v4-version-comparison"
        api_name     = "sdr-api"   
        display_name = "V4 Version Comparison "
        method       = "GET"
        url_template = "/v4/studydefinitions/{studyId}/version-comparison"
        tempname     = "studyId"
    }
    ]

}

variable "apiname" {
  
  default = [
    {
        api_name = "sdr-api"
    },
    {
        api_name = "sdr-ui-admin"
    },
    {
        api_name = "sdr-ui-api"
    }
 ]
}

variable "product_id" {
    default = "sdr-api-product"
}

variable "product_display_name" {
    default = "SDR API Product"
}

variable "product_api_name" {
    default = "sdr-api"
}

variable "management_group_name" {
  default = "sdr-apim-developer-portal-user-group"
}

variable "management_group_display_name" {
  default = "SDR API Developer Portal Access"
}

variable "developer_portal_ad_group" {
    default = "#{ADGroup_Developer_Portal}#"
}

######################API Management Variables End #############################################


######################APP Insights Begin ###################################################

variable "application_type" {
  default = "web"
}

######################APP Insights End    ###################################################


######################APP Service Begin  #####################################################

variable "https_only" {

    default = "true"
  
}

variable "ftps_state" {

    default = "Disabled"
  
}


variable "use_32_bit_worker" {
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

    default = "DenyAll"
  
}

variable "priority2" {

    default = "100"
  
}

variable "action2" {

    default = "Deny"
  
}
variable "ip_address3" {
   
   default = null

}

variable "apparname3" {

    default = "AllowVnetTraffic"
  
}

variable "priority3" {

    default = "100"
  
}

variable "action3" {

    default = "Allow"
  
}


######################APP Service End  ###################################################


######################APP Service Plan Begin  ###################################################

variable "os_type"{

    default        = "Linux"
}

variable "sku_name_asp" {

    default = "B1"
  
}

variable "funasp_os_type"{

    default        = "Windows"
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
  default = "SDR"
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

variable "index1" {

    default = ["_id"]
}

variable "index2" {

    default = ["clinicalStudy.studyId"]
}

variable "index3" {

    default =  ["auditTrail.entryDateTime"]
}

variable "index4" {

    default =  ["clinicalStudy.studyTitle"]
}

variable "index5" {

    default =  ["auditTrail.usdmVersion"]
}

variable "index6" {

    default =  ["study.studyId"]
}

variable "index7" {

    default =  ["study.Id"]
}

variable "index8" {

    default =  ["study.studyTitle"]
}

variable "collectionname1" {

    default = "Groups"

}

variable "collectionname2" {

    default = "ChangeAudit"

}
variable "collectionname3" {

  default = "StudyDefinitions"

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

/* variable "soft_delete_enabled" {

    default = "true"
} */

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

    default = "#{ADgroup1}#"

  }

variable "group2" {
  
    default = "#{ADgroup2}#"
}

variable "group3" {
  
  default = "#{ADgroup3}#"
}

variable "role1" {
   
   default = "Contributor"
}

variable "role2" {

    default = "Reader"
  
}

variable "keyvault_role" {
  
  default = "Key Vault Secrets User"
}

variable "display_name" {

    default = "#{Serviceprincipal}#"
  
}

variable "key_permissions" {

    default = ["Get","List", "Update"]
  
}

variable "secret_permissions" {
  
    default = ["Get","List","Set"]
}

variable "certificate_permissions" {
  
    default = ["Get","List","Update"]
}


###################### RBAC roles variables End  ###################################################

########################### Azure AD UI App Registration variables Begin ####################################

variable "sign_in_audience" {

    default = "AzureADMultipleOrgs"
}

variable "claimname" {

    default = "login_hint"

}

########################### Azure AD UI App Registration variables End ####################################

################################### Service Bus variables  #########################################

variable "sbqueue_name" {

    default = "changeauditsbqueue"
  
}
