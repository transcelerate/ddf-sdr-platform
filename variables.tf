####################### Variables Begin #####################################################
variable "alias_name"{
    default = "providerblock"
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

    default = ["Microsoft.Web"]
  
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

    default = ["#{Subnet-Dsaddress2}#"]
  
}


variable "service_endpoints2" {

    default = ["Microsoft.AzureCosmosDB","Microsoft.Storage","Microsoft.Web"]
  
}

####################### Delegated Subnet 2 Variable Begin   #####################################################

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

    default = [{
        name         = "clinical-study"
        display_name = "Clinical Study"
        path         = "studydefinitionrepository/v1"
    },
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
        operation_id = "search-clinical-study"
        api_name     = "clinical-study"
        display_name = "Search Clinical Study"
        method       = "POST"
        url_template = "/search"
    },
    {
        operation_id = "study-history-post"
        api_name     = "clinical-study"
        display_name = "Study History Post"
        method       = "POST"
        url_template = "/studyhistory"
    },
    {
        operation_id = "token"
        api_name     = "sdr-api"
        display_name = "Token"
        method       = "POST"
        url_template = "/v1/auth/token"
    },
    {
        operation_id = "post-study-definition"
        api_name     = "sdr-api"
        display_name = "Post Study Definition"
        method       = "POST"
        url_template = "/v1/studydefinitions"
    },
    {
        operation_id = "study-designs"
        api_name     = "sdr-api"
        display_name = "Study Designs"
        method       = "GET"
        url_template = "/v1/studydesigns"
    },
    {
        operation_id = "study-history"
        api_name     = "sdr-api"
        display_name = "Study History"
        method       = "GET"
        url_template = "/v1/studydefinitions/history"
    },
    {
        operation_id = "check-group-name"
        api_name     = "sdr-ui-admin"
        display_name = "Check Group Name"
        method       = "GET"
        url_template = "/v1/usergroups/checkgroupname"
    },
    {
        operation_id = "get-group-list"
        api_name     = "sdr-ui-admin"
        display_name = "Get Group List"
        method       = "GET"
        url_template = "/v1/usergroups/getgrouplist"
    },
    {
        operation_id = "get-groups"
        api_name     = "sdr-ui-admin"
        display_name = "Get Groups"
        method       = "POST"
        url_template = "/v1/usergroups/getgroups"
    },
    {
        operation_id = "get-users"
        api_name     = "sdr-ui-admin"
        display_name = "Get Users"
        method       = "POST"
        url_template = "/v1/usergroups/getusers"
    },
    {
        operation_id = "list-users"
        api_name     = "sdr-ui-admin"
        display_name = "List Users"
        method       = "GET"
        url_template = "/v1/usergroups/listusers"
    },
    {
        operation_id = "post-group"
        api_name     = "sdr-ui-admin"
        display_name = "Post Group"
        method       = "POST"
        url_template = "/v1/usergroups/postgroup"
    },
    {
        operation_id = "post-user"
        api_name     = "sdr-ui-admin"
        display_name = "Post User"
        method       = "POST"
        url_template = "/v1/usergroups/postuser"
    },
    {
        operation_id = "search-api"
        api_name     = "sdr-ui-api"
        display_name = "Search API"
        method       = "POST"
        url_template = "/v1/search"
    },
    {
        operation_id = "search-study-title"
        api_name     = "sdr-ui-api"
        display_name = "Search Study Title"
        method       = "POST"
        url_template = "/v1/searchstudytitle"
    },
    {
        operation_id = "usage-reports"
        api_name     = "sdr-ui-api"
        display_name = "Usage Reports"
        method       = "POST"
        url_template = "/v1/reports/usage"
    }]
  
}

variable "apioperations_tp" {

    default = [
    {
        operation_id = "all-study-elements"
        api_name     = "clinical-study"   
        display_name = "All Study Elements"
        method       = "GET"
        url_template = "/study/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "audit-trail-get"
        api_name     = "clinical-study"
        display_name = "Audit Trail Get"
        method       = "GET"
        url_template = "/audittrail/{studyId}"
        tempname     = "studyId"
    },
    # {
    #     operation_id = "study-design-sections"
    #     api_name     = "clinical-study"
    #     display_name = "Study Design Sections"
    #     method       = "GET"
    #     url_template = "/{studyId}/studydesign/{studydesignId}"
    #     tempname     = "studyId"
    # },
    {
        operation_id = "audit-trail"
        api_name     = "sdr-api"
        display_name = "Audit Trail"
        method       = "GET"
        url_template = "/v1/audittrail/{studyId}"
        tempname     = "studyId"
    },
    {
        operation_id = "get-study-definition"
        api_name     = "sdr-api"
        display_name = "Get Study Definition"
        method       = "GET"
        url_template = "/v1/studydefinitions/{studyid}"
        tempname     = "studyid"
    }
    ]

}

variable "apiname" {
  
  default = [
    {
        api_name = "clinical-study"
    },
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

######################API Management Variables End #############################################


######################APP Insights Begin ###################################################

variable "application_type" {
  default = "web"
}

######################APP Insights End    ###################################################


######################APP Service Begin  ###################################################
variable "current_stack" {

    default = "node"
}

variable "current_stack2" {

    default = "dotnet"
}


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

variable "os_type"{
    default        = "Windows"
}

variable "sku_name_asp" {

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

variable "collectionname" {

    default = "study"
}

variable "index1" {

    default = ["_id"]
}

variable "index2" {

    default = ["clinicalStudy.studyId"]
}

variable "index3" {

    default =  ["clinicalStudy.studyTitle"]
}

variable "index4" {

    default =  ["auditTrail.entryDateTime"]
}

variable "index5" {

    default =  ["clinicalStudy.uuid"]
}

variable "index6" {

    default =  ["clinicalStudy.studyPhase.decode"]
}

variable "index7" {

    default =  ["clinicalStudy.studyDesign.interventionModel.decode"]
}

variable "index8" {

    default =  ["clinicalStudy.studyDesign.studyIndications.indicationDesc"]
}

variable "index9" {

    default =  ["clinicalStudy.studyIdentifiers.studyIdentifierScope.organisationType.decode"]
}

variable "collectionname2" {

    default = "Groups"

}

variable "collectionname3" {

    default = "StudyDefinitionsV1"

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
