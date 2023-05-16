output "application_id" {

    value = azuread_application.spn_ui_test.application_id
  
}

output "object_id" {

    value = azuread_application.spn_ui_test.object_id
  
}
output "client_secret" {
  description = "Password for Application."
  value       = azuread_application_password.example.value
  sensitive   = true
}