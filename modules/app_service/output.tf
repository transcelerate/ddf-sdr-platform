output "app_service_id" {

    value = azurerm_linux_web_app.appservice.id
  
}

output "appservice_identity" {

    value = azurerm_linux_web_app.appservice.identity[0].principal_id
  
}
 
output "appservice_name" {

    value = azurerm_linux_web_app.appservice.default_hostname
  
}