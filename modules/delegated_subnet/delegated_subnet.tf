resource "azurerm_subnet" "Delegated_Subnet" {

  name                      = var.subnet_name
  virtual_network_name      = var.vnet_name
  address_prefixes          = var.address_prefix
  resource_group_name       = var.rg_name
  service_endpoints         = var.service_endpoints
  depends_on                = [var.delegated_subnet_depends_on]
  delegation {
    name = var.delegation_name
    service_delegation {
      name = var.service_delegation
      
    }
  }
}