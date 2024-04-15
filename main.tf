
terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = "=3.49.0"
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
#module "module_vnet_diagsettings" {
#  source                     = "./modules/vnet_diagsettings"
#  vnet_diag_name             = "diags-vnet-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
#  target_resource_id         = module.module_virtualnetwork.vnet_id
#  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
#  disable_log                = var.disable_log
#}
################################# Network Security Group ########################################
module "module_network_security_group" {
  source      = "./modules/network_security_group"
  nsg_name    = "nsg-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  rg_name     = module.module_resource_group.rg_name
  rg_location = module.module_resource_group.rg_location
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

################################# Network Security Group - Subnet Association ########################################
module "module_subnet_network_security_group_association" {
  source      = "./modules/subnet_nsg_association"
  subnet_id   = module.module_subnet.subnet_id
  nsg_id      = module.module_network_security_group.network_security_group_id
  depends_on  = [module.module_subnet]
}

##################################### Public IP #########################################
module "module_public_ip" {
  source              = "./modules/public_ip"
  ip_name				      = "pip-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  rg_name             = module.module_resource_group.rg_name
  rg_location         = module.module_resource_group.rg_location
  domain_name_label	  = "pip-${var.subscription_acronym}-${var.env_acronym}"
  allocation_method	  = "Static"
  sku					        = "Standard"
  protection_mode		  = "Enabled"
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
  public_ip             = module.module_public_ip.public_ip_id
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
  depends_on = [module.module_subnet_network_security_group_association, module.module_public_ip]
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


########################### AppService plan Diagonostic settings#######################################

module "module_appserviceplan02_diagsettings" {
  source                     = "./modules/app_service_plan_diagsettings"
  app_service_plan_diag_name = "diags-asp-${var.subscription_acronym}-${var.env_acronym}-${var.location}-002"
  target_resource_id         = module.module_appserviceplan2.app_service_plan_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  /* enable_metric_retention_policy = "true"
    metric_retention_days          = "7" */

}


############################ App Service ################################################

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

module "module_appservice02_diagsettings" {
  source                     = "./modules/app_service_diagsettings"
  app_service_diag_name      = "diags-apps-${var.subscription_acronym}-${var.env_acronym}-${var.location}-002"
  target_resource_id         = module.module_appservice2.app_service_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  enable_log                 = var.enable_log

}
