resource "azurerm_api_management" "apimanagement" {
  name                    = var.apim_name
  location                = var.rg_location
  resource_group_name     = var.rg_name
  publisher_name          = var.publisher_name
  publisher_email         = var.publisher_email 
  sku_name                = var.sku_name
  virtual_network_type    = var.virtual_network_type
  tags                 = var.apimanagement_tags

    virtual_network_configuration {
    
    subnet_id = var.subnet_id

  }

  identity {
    
    type = var.identity_type

  }

  protocols {

    enable_http2 = var.enable_http2
  }

  security {
    
    enable_backend_ssl30        = var.enable_backend_ssl30
    enable_backend_tls10        = var.enable_backend_tls10
    enable_backend_tls11        = var.enable_backend_tls11
    enable_frontend_ssl30       = var.enable_frontend_ssl30
    enable_frontend_tls10       = var.enable_frontend_tls10
    enable_frontend_tls11       = var.enable_frontend_tls11
#    enable_triple_des_ciphers   = var.enable_triple_des_ciphers
  }
}

resource "azurerm_api_management_custom_domain" "example" {

  api_management_id = azurerm_api_management.apimanagement.id
  

  gateway {

    host_name    = var.host_name
    negotiate_client_certificate = true
    
  }
}

resource "azurerm_api_management_api" "apiendpoint" {
  name                  = var.apiendpointname
  resource_group_name   = var.rg_name
  api_management_name   = azurerm_api_management.apimanagement.name
  revision              = "1"
  display_name          = var.apiendpointdisplayname
  path                  = var.apiendpointpath
  protocols             = ["https"]
  subscription_required = false
  service_url           = var.service_url
}

resource "azurerm_api_management_logger" "apimanagement_log" {

  name                = var.apimanagement_log
  api_management_name = azurerm_api_management.apimanagement.name
  resource_group_name = var.rg_name
  resource_id         = var.azurerm_application_insights_id

  application_insights {

    instrumentation_key = var.appinsights_instrumentation_key

  }
}
