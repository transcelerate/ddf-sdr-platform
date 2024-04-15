resource "azurerm_network_security_group" "network_security_group" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
  location            = var.rg_location

  security_rule {
    name                       = "AllowAnyCustom3443Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}