terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = "=3.99.0"
  }
}

locals {
  common_tags = {
    Environment = var.test_tag
  }
}
################################## Resource Group  #######################################################

module "module_resource_group" {
  source      = "./modules/resourcegroup"
  rg_name     = "rg-${var.subscription_acronym}app-${var.env_acronym}-${var.location}"
  rg_location = var.rg_location
  rg_tags     = local.common_tags
}