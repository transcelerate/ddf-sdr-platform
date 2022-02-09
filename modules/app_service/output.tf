output "app_service_id" {

    value = azurerm_app_service.appservice.id
  
}

output "appservice_identity" {

    value = azurerm_app_service.appservice.identity[0].principal_id
  
}