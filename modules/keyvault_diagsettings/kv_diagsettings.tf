resource "azurerm_monitor_diagnostic_setting" "kv_diag_set" {
  name               = var.kv_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "AuditEvent"
    enabled  = var.enable_log
  }
  
  log {
    category = "AzurePolicyEvaluationDetails"
    enabled  = var.enable_log
  }

   metric {
    category = "AllMetrics"
  }
}