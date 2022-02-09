resource "azurerm_storage_account" "storage_account" {
  name                            = var.storage_account_name
  location                        = var.storage_location
  resource_group_name             = var.rg_name
  account_tier                    = element(split("_", var.storage_account_type), 0)
  account_replication_type        = element(split("_", var.storage_account_type), 1)
  account_kind                    = var.storage_account_kind
  access_tier                     = var.storage_account_access_tier
  tags                            = var.storage_account_tags
  enable_https_traffic_only       = var.secure_transfer
  allow_blob_public_access        = var.enable_blob_public_access
  shared_access_key_enabled       = var.storage_account_key_access
  min_tls_version                 = var.tls_version
  is_hns_enabled                  = var.enable_hierarchical_namespace
  nfsv3_enabled                   = var.enable_network_file_system_v3
  large_file_share_enabled        = var.large_file_share_enabled

  #checkov:skip=CKV2_AZURE_18: Using Microsoft-managed keys for Storage Account encryption
  #checkov:skip=CKV2_AZURE_1:  Using Microsoft-managed keys for Storage Account encryption

  routing {

      publish_microsoft_endpoints   = var.enable_publish_microsoft_endpoints
      
  }
    
  network_rules {
      default_action = var.default_action
      virtual_network_subnet_ids = var.virtual_network_subnet_ids
      
  }
  blob_properties {
        delete_retention_policy {
        days = var.retention_days
      }
      container_delete_retention_policy {
        days = var.retention_days
      }

       versioning_enabled   = var.versioning_enabled
       change_feed_enabled = var.change_feed_enabled
  }

  queue_properties  {
      logging {
        delete                = true
        read                  = true
        write                 = true
        version               = "1.0"
        retention_policy_days = 10
    }
  }
  
}