output "storage_account_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}
output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}
output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}