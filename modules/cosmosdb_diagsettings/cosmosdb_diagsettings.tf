resource "azurerm_monitor_diagnostic_setting" "cosmosdb_diag_set" {
  name               = var.cosmosdb_diag_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "DataPlaneRequests"
    enabled  = var.enable_log
  }
  
  log {
    category = "MongoRequests"
    enabled  = var.enable_log
  }
    log {
    category = "QueryRuntimeStatistics"
    enabled  = var.enable_log
  }
    log {
    category = "PartitionKeyStatistics"
    enabled  = var.enable_log
  }
     log {
    category = "PartitionKeyRUConsumption"
    enabled  = var.enable_log
  }
  log {
    category = "ControlPlaneRequests"
    enabled  = var.enable_log
  }
    log {
    category = "CassandraRequests"
    enabled  = var.disable_log
  }
  log {
    category = "GremlinRequests"
    enabled  = var.disable_log
  }
    log {
    category = "TableApiRequests"
    enabled  = var.enable_log
  }
     metric {
    category = "Requests"
  }
}