output "application_id" {

    value = azuread_application.spn_ui_test.application_id
  
}

output "object_id" {

    value = azuread_application.spn_ui_test.object_id
  
}

output "scope_id" {

    value = azuread_application.spn_ui_test.api[0].oauth2_permission_scope
  
}