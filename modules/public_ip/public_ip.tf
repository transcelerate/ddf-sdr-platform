resource "azurerm_public_ip" "public_ip" {
  name                 = var.ip_name
  location             = var.rg_location
  resource_group_name  = var.rg_name
  domain_name_label    = var.domain_name_label
  allocation_method    = var.allocation_method
  sku                  = var.sku
  ddos_protection_mode = var.protection_mode
}