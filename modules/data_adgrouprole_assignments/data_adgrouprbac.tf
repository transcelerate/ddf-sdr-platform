data "azuread_group" "ADGroupName" {

  display_name  = var.groupdisplay_name
  security_enabled = true
  
}