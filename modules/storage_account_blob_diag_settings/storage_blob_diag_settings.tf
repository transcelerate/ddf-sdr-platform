resource "azurerm_monitor_diagnostic_setting" "storage_blob_diag__set" {
  name               = var.storage_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "StorageRead"
    enabled = var.enable_log
    
  }
  log {
    category = "StorageWrite"
    enabled = var.enable_log
    
    
  }
  log {
    category = "StorageDelete"
    enabled = var.enable_log
    
  }
  metric {
    category = "Transaction"
    
  }
}