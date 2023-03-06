resource "azurerm_monitor_diagnostic_setting" "function_app_diag_set" {
  name                       = var.function_app_diag_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "FunctionApplicationLogs"
    enabled  = var.enable_log
  }
  metric {
    category = "AllMetrics"
  }
}
