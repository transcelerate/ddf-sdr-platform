
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
module "module_vnet_diagsettings" {
  source                     = "./modules/vnet_diagsettings"
  vnet_diag_name             = "diags-vnet-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  target_resource_id         = module.module_virtualnetwork.vnet_id
  log_analytics_workspace_id = module.module_loganalytics_workspace.log_analytics_id
  disable_log                = var.disable_log
}
################################# Network Security Group ########################################
module "module_network_security_group" {
###  source              = "./modules/network_security_group"
  name                = "nsg-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
  resource_group_name = module.module_resource_group.rg_name
  location            = module.module_resource_group.rg_location

  security_rule {
    name                       = "AllowAnyCustom3443Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
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
  subnet_id                 = module.module_subnet.subnet_id
  network_security_group_id = module.module_network_security_group.id
}

##################################### API Management ####################################
#module "module_apimanagement" {
#  source                = "./modules/api_management"
#  apim_name             = "apim-${var.subscription_acronym}-${var.env_acronym}-${var.location}"
#  rg_name               = module.module_resource_group.rg_name
#  rg_location           = module.module_resource_group.rg_location
#  publisher_name        = var.publisher_name
#  publisher_email       = var.publisher_email
#  sku_name              = var.sku_name_api
#  virtual_network_type  = var.virtual_network_type
#  subnet_id             = module.module_subnet.subnet_id
#  enable_http2          = var.enable_http2
#  enable_backend_ssl30  = var.enable_backend_ssl30
#  enable_backend_tls10  = var.enable_backend_tls10
#  enable_backend_tls11  = var.enable_backend_tls11
#  enable_frontend_ssl30 = var.enable_frontend_ssl30
#  enable_frontend_tls10 = var.enable_frontend_tls10
#  enable_frontend_tls11 = var.enable_frontend_tls11
#  #      enable_triple_des_ciphers         = var.enable_triple_des_ciphers
#  apimanagement_log               = var.apimanagement_log
#  azurerm_application_insights_id = module.module_app_insights.app_insights_id
#  appinsights_instrumentation_key = module.module_app_insights.instrumentation_key
#  identity_type                   = var.identity_type
#  #   host_name                         = "apim-${var.subscription_acronym}-${var.env_acronym}-${var.location}.azure-api.net"
#  service_url      = "https://${module.module_appservice2.appservice_name}"
#  apiendpoints     = var.apiendpoints
#  apioperations    = var.apioperations
#  apioperations_tp = var.apioperations_tp
#  apiname          = var.apiname
#  apimanagement_tags = {
#
#    Environment = var.env_acronym
#    App_Layer   = var.App_Layer_NA
#  }
#}
