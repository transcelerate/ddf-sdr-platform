resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  kind                = var.app_service_plan_os
  tags                = var.app_service_plan_tags
  sku {
    tier = var.app_service_tier
    size = var.app_service_size
  }
}
