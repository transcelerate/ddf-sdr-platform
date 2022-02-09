resource "azurerm_monitor_diagnostic_setting" "vnet_diag_set" {
  name               = var.vnet_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  #  log {
  #   category = "VMProtection Alerts"
  #   enabled  = var.disable_log
  #  }
  metric {
    category = "AllMetrics"
  }
   
}