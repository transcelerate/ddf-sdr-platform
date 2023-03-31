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
  ip_range_filter       = "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"
  

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

  dynamic virtual_network_rule {
    for_each = var.subnet_id
    content {
        id = virtual_network_rule.value.id
    }
      }
}

resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  name                = var.container_name
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.acc.name
  autoscale_settings {

    max_throughput = 4000
    
  }

}

resource "azurerm_cosmosdb_mongo_collection" "mongodbCollection" {

  name = var.collectionname
  resource_group_name = var.rg_name
  account_name = azurerm_cosmosdb_account.acc.name
  database_name = azurerm_cosmosdb_mongo_database.mongodb.name
  shard_key = "_id"
  autoscale_settings {

    max_throughput = 4000
    
  }
index {keys = var.index1}
index {keys = var.index2}
index {keys = var.index3}
index {keys = var.index4}
}

resource "azurerm_cosmosdb_mongo_collection" "mongodbCollection2" {

  name = var.collectionname2
  resource_group_name = var.rg_name
  account_name = azurerm_cosmosdb_account.acc.name
  database_name = azurerm_cosmosdb_mongo_database.mongodb.name
  shard_key = "_id"
  autoscale_settings {

    max_throughput = 4000
    
  }
index {keys = var.index1}
}

resource "azurerm_cosmosdb_mongo_collection" "mongodbCollection3" {

  name = var.collectionname3
  resource_group_name = var.rg_name
  account_name = azurerm_cosmosdb_account.acc.name
  database_name = azurerm_cosmosdb_mongo_database.mongodb.name
  shard_key = "_id"
  autoscale_settings {

    max_throughput = 4000
    
  }
index {keys = var.index1}
index {keys = var.index4}
index {keys = var.index3}
index {keys = var.index5}
index {keys = var.index6}
index {keys = var.index7}
index {keys = var.index8}
index {keys = var.index9}
}

resource "azurerm_cosmosdb_mongo_collection" "mongodbCollection4" {

  name = var.collectionname4
  resource_group_name = var.rg_name
  account_name = azurerm_cosmosdb_account.acc.name
  database_name = azurerm_cosmosdb_mongo_database.mongodb.name
  shard_key = "_id"
  autoscale_settings {

    max_throughput = 4000
    
  }
index {keys = var.index1}
} 
resource "azurerm_cosmosdb_mongo_collection" "mongodbCollection5" {

  name = var.collectionname5
  resource_group_name = var.rg_name
  account_name = azurerm_cosmosdb_account.acc.name
  database_name = azurerm_cosmosdb_mongo_database.mongodb.name
  shard_key = "_id"
  autoscale_settings {

    max_throughput = 4000
    
  }
index {keys = var.index1}
index {keys = var.index2}
index {keys = var.index3}
index {keys = var.index4}
index {keys = var.index10}
}
