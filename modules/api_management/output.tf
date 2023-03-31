output "api_management_id" {

    value = azurerm_api_management.apimanagement.id
  
}
  
output "apim_identity" {

    value = azurerm_api_management.apimanagement.identity[0].principal_id
  
}