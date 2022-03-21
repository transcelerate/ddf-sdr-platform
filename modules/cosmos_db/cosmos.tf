resource "azurerm_cosmosdb_account" "acc" {
  name                                = var.cosmos_db_account_name
  location                            = var.rg_location
  resource_group_name                 = var.rg_name
  offer_type                          = var.offer_type
  kind                                = var.cosmos_kind
  is_virtual_network_filter_enabled   = var.is_virtual_network_filter_enabled
  mongo_server_version                = var.mongo_version
  enable_automatic_failover           = var.enable_automatic_failover
  enable_free_tier                    = var.enable_free_tier
  tags                                = var.cosmosdb_tags
  access_key_metadata_writes_enabled  = var.access_key_metadata_writes_enabled
  public_network_access_enabled       = true
  

#checkov:skip=CKV_AZURE_100: Using Microsoft-managed keys for Cosmos DB Account encryption

  consistency_policy {
      consistency_level = var.consistency_level
  }
  geo_location {
      location = var.backup_location
      failover_priority = 0
  }
    
  backup {
    type = var.backup_type
    interval_in_minutes = var.interval_minutes 
    retention_in_hours = var.interval_hours
  }

  virtual_network_rule {
        id = var.subnet_id
  }
}

resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  name                = var.container_name
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.acc.name
  throughput          = var.throughput

}

