resource "azurerm_monitor_diagnostic_setting" "diag_set" {
  name               = var.apim_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "GatewayLogs"
    enabled  = var.enable_log
  }
  
  log {
    category = "WebSocketConnectionLogs"
    enabled  = var.enable_log
  }
  
}
