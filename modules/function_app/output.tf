output "functionapp_id" {

  value = azurerm_windows_functionapp.functionapp.id

}
output "functionapp_identity" {

  value = azurerm_windows_functionapp.functionapp.identity[0].principal_id

}
output "functionapp_name" {

  value = azurerm_windows_functionapp.functionapp.name
}
