resource "azurerm_linux_web_app" "appservice" {
  name                = var.app_service_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  service_plan_id     = var.app_service_plan_id
  tags                = var.app_service_tags
  https_only          = var.https_only
  
  #checkov:skip=CKV_AZURE_88:Using log analytics workspace for logs 
  #checkov:skip=CKV_AZURE_17:Not Using certificate base authentication

  identity {
    
      type = var.identity

  }

  site_config {

    application_stack  {

    docker_image = var.docker_image
    docker_image_tag = "latest"

  }
  
    use_32_bit_worker         = var.use_32_bit_worker
    ftps_state                = var.ftps_state
    http2_enabled             = var.http2_enabled
    default_documents         = [ "index.html" ]
    ip_restriction {
      
      ip_address                = var.ip_address
      virtual_network_subnet_id = var.virtual_network_subnet_id
      name                      = var.apparname
      priority                  = var.priority
      action                    = var.action
        
    }
    
  }
  app_settings = {
    
    APPINSIGHTS_INSTRUMENTATIONKEY          = var.APPINSIGHTS_INSTRUMENTATIONKEY
    APPLICATIONINSIGHTS_CONNECTION_STRING   = var.APPLICATIONINSIGHTS_CONNECTION_STRING

  }

  logs {
    
    failed_request_tracing  = true
    detailed_error_messages = true
    http_logs {
      
      file_system {
        
        retention_in_days = 30
        retention_in_mb   = 30

      }
    }

  }

  
}

resource "azurerm_app_service_virtual_network_swift_connection" "Vnet_Integration" {
  app_service_id = azurerm_linux_web_app.appservice.id
  subnet_id      = var.subnet_id
}