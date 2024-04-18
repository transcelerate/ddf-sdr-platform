resource "azurerm_network_security_group" "network_security_group" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
  location            = var.rg_location
}

resource "azurerm_network_security_rule" "networksecurityrule" {
    for_each                    = { for security_rule in var.network_security_rules : security_rule.name => security_rule }
    name                        = each.value.name
    priority                    = each.value.priority
    direction                   = each.value.direction
    access                      = each.value.access
    protocol                    = each.value.protocol
    source_port_range           = each.value.source_port_range
    destination_port_range      = each.value.destination_port_range
    destination_port_ranges     = each.value.destination_port_ranges
    source_address_prefix       = each.value.source_address_prefix
    destination_address_prefix  = each.value.destination_address_prefix
    resource_group_name         = var.rg_name
    network_security_group_name = azurerm_network_security_group.network_security_group.name
}