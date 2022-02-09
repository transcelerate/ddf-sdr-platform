resource "azurerm_role_assignment" "role" {

  scope                = var.resource_id
  role_definition_name = var.role
  principal_id         = var.principal_id
  
}
