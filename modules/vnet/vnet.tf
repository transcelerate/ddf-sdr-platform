resource "azurerm_virtual_network" "vnet" {

  name = var.vnet_name
  address_space = var.address_space
  location = var.rg_location
  resource_group_name = var.rg_name
  tags = var.vnet_tags
}


