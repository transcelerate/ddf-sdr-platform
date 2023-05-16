output "app_insights_id" {

    value = azurerm_application_insights.app_insights.id
  
}
output "instrumentation_key" {

  value = azurerm_application_insights.app_insights.instrumentation_key
  
}

output "connection_string" {

  value = azurerm_application_insights.app_insights.connection_string
  
}
output "read_telemetry_api_key" {

  value = azurerm_application_insights_api_key.read_telemetry.api_key
  
}