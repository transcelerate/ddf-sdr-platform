data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault_creation" {

  name                            = var.keyvault_name
  location                        = var.rg_location
  resource_group_name             = var.rg_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_deployment          = var.enabled_for_deployment
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku_name
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
#  soft_delete_enabled             = var.soft_delete_enabled
  tags                            = var.key_vault_tags
  network_acls {
    default_action = "Allow"
    bypass = "AzureServices" 
 }

}