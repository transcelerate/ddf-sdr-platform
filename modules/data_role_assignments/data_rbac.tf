
data "azuread_group" "ADGroupName" {

  display_name  = var.display_name
  security_enabled = true
  
}
