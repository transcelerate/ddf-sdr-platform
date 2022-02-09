output "tenant_id" {

  value = data.azurerm_client_config.current.tenant_id

}

output "keyvault_uri" {

  value = azurerm_key_vault.keyvault_creation.vault_uri

}

output "keyvault_id" {

  value = azurerm_key_vault.keyvault_creation.id

}