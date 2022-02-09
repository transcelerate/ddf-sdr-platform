resource "azurerm_monitor_diagnostic_setting" "storage_diag_set" {
  name               = var.storage_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  
  metric {
    category = "Transaction"
    
  }
}