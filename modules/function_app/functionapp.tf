
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

  storage_account_name       = azurerm_storage_account.funappstorageaccount.name
  storage_account_access_key = azurerm_storage_account.funappstorageaccount.primary_access_key
  service_plan_id            = var.service_plan_id
  
  site_config {
    ftps_state  = "Disabled"
    application_stack {
      
    dotnet_version = "6"
  
    }
  }

  identity {
    
    type = "SystemAssigned"
  }

  app_settings = {

    AzureServiceBusConnectionString = var.AzureServiceBusConnectionString
    AzureServiceBusQueueName        = var.AzureServiceBusQueueName
    KeyVaultName                    = var.KeyVaultName
  }

}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {

  app_service_id = azurerm_windows_function_app.functionapp.id
  subnet_id      = var.subnet_id

}
