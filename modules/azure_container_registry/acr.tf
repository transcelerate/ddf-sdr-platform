resource "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  tags                = var.acr_tags
  admin_enabled       = true
} 