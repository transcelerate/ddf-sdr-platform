
terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = "=3.1.0"
  }
}
locals {
  common_tags = {
    Environment = var.env_acronym
  }
}
################################## Resource Group  #######################################################

module "module_resource_group" {
  source      = "./modules/resourcegroup"
  rg_name     = "rg-${var.subscription_acronym}app-${var.env_acronym}-${var.location}"
  rg_location = var.rg_location
  rg_tags     = local.common_tags
}

module "module_resource_group_2" {
  source      = "./modules/resourcegroup"
  rg_name     = "rg-${var.subscription_acronym}core-${var.env_acronym}-${var.location}"
  rg_location = var.rg_location
  rg_tags     = local.common_tags
}

################################## VNET #######################################################

module "module_virtualnetwork" {
  source        = "./modules/vnet"
  vnet_name     = "vnet-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  address_space = var.address_space
  rg_name       = module.module_resource_group_2.rg_name
  rg_location   = module.module_resource_group_2.rg_location
  vnet_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_NA
  }
}
################################## VNET Diagonostic Settings ###################################
module "module_vnet_diagsettings" {
  source                     = "./modules/vnet_diagsettings"
  vnet_diag_name             = "diags-vnet-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  target_resource_id         = module.module_virtualnetwork.vnet_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  disable_log                = var.disable_log
}
################################## Subnet #######################################################
module "module_subnet" {
  source            = "./modules/subnet"
  subnet_name       = "snet-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  vnet_name         = module.module_virtualnetwork.vnet_name
  address_prefix    = var.address_prefix
  rg_name           = module.module_resource_group_2.rg_name
  rg_location       = module.module_resource_group_2.rg_location
  service_endpoints = var.sub_service_endpoints
  depends_on        = [module.module_virtualnetwork]
}

module "module_deligatedsubnet1" {
  source             = "./modules/delegated_subnet"
  subnet_name        = "dsnet-${var.subscription_acronym}${var.fe_acronym}-${var.env_acronym}-${var.location}-001"
  vnet_name          = module.module_virtualnetwork.vnet_name
  address_prefix     = var.dsaddress_prefix
  rg_name            = module.module_resource_group_2.rg_name
  service_delegation = var.service_delegation
  service_endpoints  = var.service_endpoints
  delegation_name    = var.delegation_name
  depends_on         = [module.module_virtualnetwork]
}

module "module_deligatedsubnet2" {
  source             = "./modules/delegated_subnet"
  subnet_name        = "dsnet-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}-002"
  vnet_name          = module.module_virtualnetwork.vnet_name
  address_prefix     = var.dsaddress_prefix2
  rg_name            = module.module_resource_group_2.rg_name
  service_delegation = var.service_delegation
  service_endpoints  = var.service_endpoints2
  delegation_name    = var.delegation_name
  depends_on         = [module.module_virtualnetwork]
}

module "module_deligatedsubnet3" {
  source             = "./modules/delegated_subnet"
  subnet_name        = "dsnetfunapp-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}-002"
  vnet_name          = module.module_virtualnetwork.vnet_name
  address_prefix     = var.dsaddress_prefix3
  rg_name            = module.module_resource_group_2.rg_name
  service_delegation = var.service_delegation
  service_endpoints  = var.service_endpoints2
  delegation_name    = var.delegation_name
  depends_on         = [module.module_virtualnetwork]
}

################################## Log Analytics Workspace ################################################

module "module_loganalytics_workspace" {
  source                       = "./modules/log_analytics_workspace"
  log_analytics_workspace_name = "law-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  rg_location                  = module.module_resource_group_2.rg_location
  rg_name                      = module.module_resource_group_2.rg_name
  sku                          = var.log_analytics_sku
  retention_in_days            = var.log_analytics_retention
  log_analytics_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_NA
  }
}
################################ Log Analytics Diagonostic settings #############################
module "module_log_analytics_diagsettings" {
  source                     = "./modules/log_analy_diagsettings"
  log_analytics_diag_name    = "diags-law-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  target_resource_id         = module.module_loganalytics_workspace.log_analytics_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log
}
################################## Key Vault ################################################

module "module_keyvault" {

  source                          = "./modules/key_vault"
  rg_name                         = module.module_resource_group_2.rg_name
  rg_location                     = module.module_resource_group_2.rg_location
  keyvault_name                   = "kv-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  sku_name                        = var.sku_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_deployment          = var.enabled_for_deployment
  purge_protection_enabled        = var.purge_protection_enabled
  #    soft_delete_enabled             = var.soft_delete_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  key_vault_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_NA

  }

}
################################## Key Vault Diagnostic Settings ################################################

module "module_keyvault_diagsettings" {
  source                     = "./modules/keyvault_diagsettings"
  kv_diag_name               = "diags-kv-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  target_resource_id         = module.module_keyvault.keyvault_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log

}

################################## Cosmos DB ################################################
module "module_cosmosdb" {
  source                             = "./modules/cosmos_db"
  cosmos_db_account_name             = "cdb-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  rg_name                            = module.module_resource_group.rg_name
  rg_location                        = module.module_resource_group.rg_location
  offer_type                         = var.offer_type
  cosmos_kind                        = var.cosmos_kind
  mongo_version                      = var.mongo_version
  consistency_level                  = var.consistency_level
  backup_location                    = var.backup_location
  backup_type                        = var.backup_type
  interval_minutes                   = var.interval_minutes
  interval_hours                     = var.interval_hours
  subnet_id                          = [{ id = module.module_deligatedsubnet2.Dsubnet_ID }, { id = module.module_deligatedsubnet3.Dsubnet_ID }]
  container_name                     = var.container_name
  throughput                         = var.throughput
  is_virtual_network_filter_enabled  = var.is_virtual_network_filter_enabled
  enable_automatic_failover          = var.enable_automatic_failover
  enable_free_tier                   = var.enable_free_tier
  access_key_metadata_writes_enabled = var.access_key_metadata_writes_enabled
  collectionname                     = var.collectionname
  collectionname2                    = var.collectionname2
  collectionname3                    = var.collectionname3
  collectionname4                    = var.collectionname4
  collectionname5                    = var.collectionname5
  index1                             = var.index1
  index2                             = var.index2
  index3                             = var.index3
  index4                             = var.index4
  index5                             = var.index5
  index6                             = var.index6
  index7                             = var.index7
  index8                             = var.index8
  index9                             = var.index9
  index10                            = var.index10
  cosmosdb_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_BE

  }


}
#################################### CosmosDB Diagonostic settings ##################################
module "module_cosmosdb_diagsettings" {
  source                     = "./modules/cosmosdb_diagsettings"
  cosmosdb_diag_name         = "diags-cdb-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  target_resource_id         = module.module_cosmosdb.cosmosdb_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log
  disable_log                = var.disable_log
}
##################################### API Management ####################################
module "module_apimanagement" {
  source                = "./modules/api_management"
  apim_name             = "apim-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  rg_name               = module.module_resource_group.rg_name
  rg_location           = module.module_resource_group.rg_location
  publisher_name        = var.publisher_name
  publisher_email       = var.publisher_email
  sku_name              = var.sku_name_api
  virtual_network_type  = var.virtual_network_type
  subnet_id             = module.module_subnet.subnet_id
  enable_http2          = var.enable_http2
  enable_backend_ssl30  = var.enable_backend_ssl30
  enable_backend_tls10  = var.enable_backend_tls10
  enable_backend_tls11  = var.enable_backend_tls11
  enable_frontend_ssl30 = var.enable_frontend_ssl30
  enable_frontend_tls10 = var.enable_frontend_tls10
  enable_frontend_tls11 = var.enable_frontend_tls11
  #      enable_triple_des_ciphers         = var.enable_triple_des_ciphers
  apimanagement_log               = var.apimanagement_log
  azurerm_application_insights_id = module.module_app_insights.app_insights_id
  appinsights_instrumentation_key = module.module_app_insights.instrumentation_key
  identity_type                   = var.identity_type
  #   host_name                         = "apim-${var.subscription_acronym}-${var.env_acronym}-${var.location}.azure-api.net"
  service_url      = "https://${module.module_appservice2.appservice_name}"
  apiendpoints     = var.apiendpoints
  apioperations    = var.apioperations
  apioperations_tp = var.apioperations_tp
  apiname          = var.apiname
  apimanagement_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_NA
  }
}


####################################API Management Diagnostic Settings###########################
module "module_api_management_diagsettings" {
  source                     = "./modules/api_management_diagsettings"
  apim_diag_name             = "diags-apim-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  target_resource_id         = module.module_apimanagement.api_management_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log
}
##################################  App Insights #########################################

module "module_app_insights" {
  source                     = "./modules/app_insights"
  app_insights_name          = "appin-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  rg_name                    = module.module_resource_group.rg_name
  rg_location                = module.module_resource_group.rg_location
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  application_type           = var.application_type
  app_insights_tags = {
    Environment = var.env_acronym
    App_Layer   = var.App_Layer_NA
  }
}

###############################  Azure Container Registry ########################################

module "acr" {

  source              = "./modules/azure_container_registry"
  acrname             = "acr${var.subscription_acronym}${var.env_acronym}${var.location}"
  resource_group_name = module.module_resource_group.rg_name
  location            = module.module_resource_group.rg_location
  acr_tags = {

    Environment = var.env_acronym

  }
}


##################################  App Service Plan ########################################
module "module_appserviceplan" {
  source                = "./modules/app_service_plan"
  app_service_plan_name = "asp-${var.subscription_acronym}${var.fe_acronym}-${var.env_acronym}-${var.location}-001"
  rg_name               = module.module_resource_group.rg_name
  rg_location           = module.module_resource_group.rg_location
  os_type               = var.os_type
  sku_name              = var.sku_name_asp
  app_service_plan_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_FE
  }

}

module "module_appserviceplan2" {
  source                = "./modules/app_service_plan"
  app_service_plan_name = "asp-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}-002"
  rg_name               = module.module_resource_group.rg_name
  rg_location           = module.module_resource_group.rg_location
  os_type               = var.os_type
  sku_name              = var.sku_name_asp
  app_service_plan_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_BE
  }

}

module "module_appserviceplan3" {
  source                = "./modules/app_service_plan"
  app_service_plan_name = "funasp-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}-003"
  rg_name               = module.module_resource_group.rg_name
  rg_location           = module.module_resource_group.rg_location
  os_type               = var.funasp_os_type
  sku_name              = var.sku_name_asp
  app_service_plan_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_BE
  }

}
########################### AppService plan Diagonostic settings#######################################
module "module_appserviceplan01_diagsettings" {
  source                     = "./modules/app_service_plan_diagsettings"
  app_service_plan_diag_name = "diags-asp-${var.subscription_acronym}-${var.env_acronym}-${var.location}-001"
  target_resource_id         = module.module_appserviceplan.app_service_plan_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  /* enable_metric_retention_policy = "true"
    metric_retention_days          = "7" */

}
module "module_appserviceplan02_diagsettings" {
  source                     = "./modules/app_service_plan_diagsettings"
  app_service_plan_diag_name = "diags-asp-${var.subscription_acronym}-${var.env_acronym}-${var.location}-002"
  target_resource_id         = module.module_appserviceplan2.app_service_plan_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  /* enable_metric_retention_policy = "true"
    metric_retention_days          = "7" */

}

module "module_appserviceplan03_diagsettings" {
  source                     = "./modules/app_service_plan_diagsettings"
  app_service_plan_diag_name = "diags-funasp-${var.subscription_acronym}-${var.env_acronym}-${var.location}-003"
  target_resource_id         = module.module_appserviceplan3.app_service_plan_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  /* enable_metric_retention_policy = "true"
    metric_retention_days          = "7" */

}

############################ App Service ################################################
module "module_appservice" {
  source                                = "./modules/app_service"
  app_service_name                      = "apps-${var.subscription_acronym}${var.fe_acronym}-${var.env_acronym}-${var.location}-001"
  rg_name                               = module.module_resource_group.rg_name
  rg_location                           = module.module_resource_group.rg_location
  app_service_plan_id                   = module.module_appserviceplan.app_service_plan_id
  APPINSIGHTS_INSTRUMENTATIONKEY        = module.module_app_insights.instrumentation_key
  APPLICATIONINSIGHTS_CONNECTION_STRING = module.module_app_insights.connection_string
  https_only                            = var.https_only
  ftps_state                            = var.ftps_state
  use_32_bit_worker                     = var.use_32_bit_worker
  docker_image                          = module.acr.acrurl
  identity                              = var.identity
  http2_enabled                         = var.http2_enabled
  subnet_id                             = module.module_deligatedsubnet1.Dsubnet_ID
  virtual_network_subnet_id             = null
  ip_address                            = var.ip_address
  apparname                             = var.apparname
  priority                              = var.priority
  action                                = var.action
  depends_on                            = [module.module_deligatedsubnet1]
  app_service_tags = {
    Environment = var.env_acronym
    App_Layer   = var.App_Layer_FE
  }
}

module "module_appservice2" {
  source                                = "./modules/app_service"
  app_service_name                      = "apps-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}-002"
  rg_name                               = module.module_resource_group.rg_name
  rg_location                           = module.module_resource_group.rg_location
  app_service_plan_id                   = module.module_appserviceplan2.app_service_plan_id
  APPINSIGHTS_INSTRUMENTATIONKEY        = module.module_app_insights.instrumentation_key
  APPLICATIONINSIGHTS_CONNECTION_STRING = module.module_app_insights.connection_string
  https_only                            = var.https_only
  ftps_state                            = var.ftps_state
  use_32_bit_worker                     = var.use_32_bit_worker
  docker_image                          = module.acr.acrurl
  identity                              = var.identity
  http2_enabled                         = var.http2_enabled
  subnet_id                             = module.module_deligatedsubnet2.Dsubnet_ID
  virtual_network_subnet_id             = module.module_subnet.subnet_id
  ip_address                            = var.ip_address2
  apparname                             = var.apparname2
  priority                              = var.priority2
  action                                = var.action2
  depends_on                            = [module.module_deligatedsubnet2, module.module_subnet, module.module_virtualnetwork]
  app_service_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_BE
  }
}
########################### App Service Diagonostic Settings ####################################
module "module_appservice01_diagsettings" {
  source                     = "./modules/app_service_diagsettings"
  app_service_diag_name      = "diags-apps-${var.subscription_acronym}-${var.env_acronym}-${var.location}-001"
  target_resource_id         = module.module_appservice.app_service_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log

}
module "module_appservice02_diagsettings" {
  source                     = "./modules/app_service_diagsettings"
  app_service_diag_name      = "diags-apps-${var.subscription_acronym}-${var.env_acronym}-${var.location}-002"
  target_resource_id         = module.module_appservice2.app_service_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log

}
# module "module_functionapp_diagsettings" {
#   source                     = "./modules/functionapp_diagsettings"
#   functionapp_diag_name      = "diags-funapp-${var.subscription_acronym}-${var.env_acronym}-${var.location}-003"
#   target_resource_id         = module.module_functionapp.function_app_id
#   log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
#   enable_log                 = var.enable_log

# }

################################ Function App ########################################

module "module_functionapp" {

  source                                 = "./modules/function_app"
  functionapp_name                       = "funapp-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}"
  storageaccount_name                    = "fappsa${var.subscription_acronym}${var.env_acronym}${var.location}"
  resource_group_name                    = module.module_resource_group.rg_name
  location                               = module.module_resource_group.rg_location
  service_plan_id                        = module.module_appserviceplan3.app_service_plan_id
  AzureServiceBusConnectionString        = "Endpoint=sb://${module.module_servicebus.sbname}.servicebus.windows.net/;SharedAccessKeyName=${module.module_servicebus.sbqueuearn};SharedAccessKey=${module.module_servicebus.sbqueue_authidps}"
  AzureServiceBusQueueName               = module.module_servicebus.sbqueue_name
  KeyVaultName                           = module.module_keyvault.keyvault_uri
  subnet_id                              = module.module_deligatedsubnet3.Dsubnet_ID
  virtual_network_subnet_id              = module.module_subnet.subnet_id
  ip_address                             = var.ip_address3
  apparname                              = var.apparname3
  priority                               = var.priority3
  action                                 = var.action3
  application_insights_key               = module.module_app_insights.instrumentation_key
  application_insights_connection_string = module.module_app_insights.connection_string
  https_only                             = var.https_only
  depends_on                             = [module.module_deligatedsubnet3, module.module_subnet, module.module_virtualnetwork, module.module_servicebus]
  functionapp_tags = {

    Environment = var.env_acronym
    App_Layer   = var.App_Layer_BE

  }
}

############################## Service Bus ############################################

module "module_servicebus" {

  source              = "./modules/service_bus"
  servicebus_name     = "asb-${var.subscription_acronym}${var.be_acronym}-${var.env_acronym}-${var.location}"
  resource_group_name = module.module_resource_group.rg_name
  location            = module.module_resource_group.rg_location
  sbqueue_name        = var.sbqueue_name
  servicebus_tags = {
    Environment = var.env_acronym
    App_Layer   = var.App_Layer_NA
  }

}

########################### RBAC role assignments ####################################
module "module_adgroup_data_rgapp" {

  for_each          = toset([var.group1, var.group2, var.group3])
  source            = "./modules/data_adgrouprole_assignments"
  groupdisplay_name = format("%s", each.key)

}

module "module_adgroup_data_rgcore" {

  source            = "./modules/data_adgrouprole_assignments"
  groupdisplay_name = var.group3
}

module "module_rbac_cosmosdb" {

  source       = "./modules/role_assignment"
  resource_id  = module.module_cosmosdb.cosmosdb_id
  role         = var.cosmosdb_role
  principal_id = module.module_appservice2.appservice_identity

}

module "module_rbac_apim" {
  source       = "./modules/role_assignment"
  resource_id  = module.module_apimanagement.api_management_id
  role         = var.apim_role
  principal_id = module.module_appservice.appservice_identity

}

module "module_rbac_appservice1" {

  source       = "./modules/role_assignment"
  resource_id  = module.module_appservice.app_service_id
  role         = var.appservice1_role
  principal_id = module.module_apimanagement.apim_identity

}

module "module_rbac_appservice2" {

  source       = "./modules/role_assignment"
  resource_id  = module.module_appservice2.app_service_id
  role         = var.appservice2_role
  principal_id = module.module_apimanagement.apim_identity

}

module "module_rbac_rgapp" {
  for_each = { (var.group1) = var.role1
    (var.group2) = var.role1
  (var.group3) = var.role2 }
  source       = "./modules/role_assignment"
  resource_id  = module.module_resource_group.rg_id
  role         = each.value
  principal_id = module.module_adgroup_data_rgapp[each.key].adgroup_id

}

module "module_rbac_rgcore" {

  source       = "./modules/role_assignment"
  resource_id  = module.module_resource_group_2.rg_id
  role         = var.role2
  principal_id = module.module_adgroup_data_rgcore.adgroup_id

}


module "module_data_spdata" {
  source       = "./modules/data_sprole_assignments"
  display_name = var.display_name
}

module "module_rbac_keyvault_ui" {
  source       = "./modules/role_assignment"
  resource_id  = module.module_keyvault.keyvault_id
  role         = var.keyvault_role
  principal_id = module.module_appservice.appservice_identity
}

module "module_rbac_keyvault_api" {
  source       = "./modules/role_assignment"
  resource_id  = module.module_keyvault.keyvault_id
  role         = var.keyvault_role
  principal_id = module.module_appservice2.appservice_identity
}

########################### Key Vault Access Policies ####################################
module "module_keyvault_access_policy_devops" {

  source                  = "./modules/key_vault_accesspolicy"
  key_vault_id            = module.module_keyvault.keyvault_id
  tenant_id               = module.module_keyvault.tenant_id
  object_id               = module.module_data_spdata.spobject_id
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}

module "module_keyvault_access_policy_appservice_ui" {
  source                  = "./modules/key_vault_accesspolicy"
  key_vault_id            = module.module_keyvault.keyvault_id
  tenant_id               = module.module_keyvault.tenant_id
  object_id               = module.module_appservice.appservice_identity
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions

}

module "module_keyvault_access_policy_appservice_api" {
  source                  = "./modules/key_vault_accesspolicy"
  key_vault_id            = module.module_keyvault.keyvault_id
  tenant_id               = module.module_keyvault.tenant_id
  object_id               = module.module_appservice2.appservice_identity
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}
module "module_keyvault_access_policy_function_app_funapp" {
  source                  = "./modules/key_vault_accesspolicy"
  key_vault_id            = module.module_keyvault.keyvault_id
  tenant_id               = module.module_keyvault.tenant_id
  object_id               = module.module_functionapp.functionapp_identity
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}

########################### Azure AD UI App Registration ####################################

module "module_app_registration" {
  source           = "./modules/azuread_appregistration"
  display_name     = "spn_${var.subscription_acronym}_${var.env_acronym}_${var.fe_acronym}"
  sign_in_audience = var.sign_in_audience
  claimname        = var.claimname
  redirect_uris    = ["https://${module.module_appservice.appservice_name}/"]
  depends_on       = [module.module_appservice]

}
