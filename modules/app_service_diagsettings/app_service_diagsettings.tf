resource "azurerm_monitor_diagnostic_setting" "app_diag_set" {
  name                       = var.app_service_diag_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "AppServiceHTTPLogs"
    enabled  = var.enable_log
  }
  
  log {
    category = "AppServiceConsoleLogs"
    enabled  = var.enable_log
  }
    log {
    category = "AppServiceAppLogs"
    enabled  = var.enable_log
  }
    log {
    category = "AppServiceAuditLogs"
    enabled  = var.enable_log
  }
    log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = var.enable_log
  }
     log {
    category = "AppServicePlatformLogs"
    enabled  = var.enable_log
  }
     metric {
    category = "AllMetrics"
  }
}
