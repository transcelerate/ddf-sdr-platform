resource "azurerm_monitor_diagnostic_setting" "app_insights_diag_set" {
  name               = var.appinsights_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
log {
category = "AppAvailabilityResults"
enabled = var.enable_log
}
log {
category = "AppBrowserTimings"
enabled = var.enable_log
}
log {
category = "AppEvents"
enabled = var.enable_log
}
log {
category = "AppMetrics"
enabled = var.enable_log
}
log {
category = "AppDependencies"
enabled = var.enable_log
}
log {
category = "AppExceptions"
enabled = var.enable_log
}
log {
category = "AppPageViews"
enabled = var.enable_log
}
log {
category = "AppPerformanceCounters"
enabled = var.enable_log
}
log {
category = "AppRequests"
enabled = var.enable_log
}
log {
category = "AppSystemEvents"
enabled = var.enable_log
}
log {
category = "AppTraces"
enabled = var.enable_log
}
   metric {
    category = "AllMetrics"
  }  
}