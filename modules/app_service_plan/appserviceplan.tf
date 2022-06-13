resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  tags                = var.app_service_plan_tags
  os_type             = var.os_type
  sku_name            = var.sku_name
}
