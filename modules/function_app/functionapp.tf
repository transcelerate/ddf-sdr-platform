
resource "azurerm_storage_account" "funappstorageaccount" {
  name                     = var.storageaccount_name
  resource_group_name      = var.resource_group_name 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}


 
resource "azurerm_windows_function_app" "functionapp" {
  name                = var.functionapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.functionapp_tags
  https_only          = var.https_only

  storage_account_name       = azurerm_storage_account.funappstorageaccount.name
  storage_account_access_key = azurerm_storage_account.funappstorageaccount.primary_access_key
  service_plan_id            = var.service_plan_id
  
  site_config {
    ftps_state  = "Disabled"
    application_stack {
      
    dotnet_version = "6"
  
    }
    ip_restriction {
      
      ip_address                = var.ip_address
      virtual_network_subnet_id = var.virtual_network_subnet_id
      name                      = var.apparname
      priority                  = var.priority
      action                    = var.action
        
    }
  }

  identity {
    
    type = "SystemAssigned"
  }

  app_settings = {

    AzureServiceBusConnectionString         = var.AzureServiceBusConnectionString
    AzureServiceBusQueueName                = var.AzureServiceBusQueueName
    KeyVaultName                            = var.KeyVaultName
    application_insights_key                = var.application_insights_key  
    application_insights_connection_string  = var.application_insights_connection_string
  }

}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {

  app_service_id = azurerm_windows_function_app.functionapp.id
  subnet_id      = var.subnet_id

}
