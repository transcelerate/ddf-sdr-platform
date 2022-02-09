resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = var.log_analytics_tags
}