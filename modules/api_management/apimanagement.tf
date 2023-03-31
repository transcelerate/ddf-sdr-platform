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

# resource "azurerm_api_management_custom_domain" "example" {

#  api_management_id = azurerm_api_management.apimanagement.id
  

#   gateway {

#     host_name    = var.host_name
#     negotiate_client_certificate = true
    
#   }
# }
 
resource "azurerm_api_management_api" "apiendpoint" {
  for_each              = {for endpoint in var.apiendpoints : endpoint.name => endpoint}
  name                  = each.value.name
  resource_group_name   = var.rg_name
  api_management_name   = azurerm_api_management.apimanagement.name
  revision              = "1"
  display_name          = each.value.display_name
  path                  = each.value.path
  protocols             = ["https"]
  subscription_required = false
  service_url           = var.service_url
}

resource "azurerm_api_management_api_operation" "apioperations" {
  for_each            = {for api in var.apioperations : api.operation_id => api}
  operation_id        = each.value.operation_id
  api_name            = each.value.api_name
  api_management_name = azurerm_api_management.apimanagement.name
  resource_group_name = var.rg_name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = each.value.url_template
  description         = "SDR API's"
  depends_on          = [azurerm_api_management_api.apiendpoint]

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "apioperations_tp" {
  for_each            = {for api in var.apioperations_tp : api.operation_id => api}
  operation_id        = each.value.operation_id
  api_name            = each.value.api_name
  api_management_name = azurerm_api_management.apimanagement.name
  resource_group_name = var.rg_name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = each.value.url_template
  description         = "SDR API's"
  depends_on          = [azurerm_api_management_api.apiendpoint]

  template_parameter {
    name    = each.value.tempname
    type    = "string"
    required = false
  }

  response {
    status_code = 200
  }
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

resource "azurerm_api_management_api_diagnostic" "example" {
  for_each                 = {for api in var.apiname : api.api_name => api}
  identifier               = "applicationinsights"
  resource_group_name      = var.rg_name
  api_management_name      = azurerm_api_management.apimanagement.name
  api_name                 = each.value.api_name
  api_management_logger_id = azurerm_api_management_logger.apimanagement_log.id
  depends_on               = [azurerm_api_management_api.apiendpoint]

  sampling_percentage       = 100.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "information"
  http_correlation_protocol = "W3C"

}
