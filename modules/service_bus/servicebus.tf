
resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  tags                = var.servicebus_tags
}
resource "azurerm_servicebus_queue" "sbqueue" {
  name         = var.sbqueue_name
  namespace_id = azurerm_servicebus_namespace.servicebus.id

  enable_partitioning = false
} 

resource "azurerm_servicebus_queue_authorization_rule" "sbqueueaccessrule" {
  name     = "funappaccessrule"
  queue_id = azurerm_servicebus_queue.sbqueue.id

  listen = true
  send   = true
  manage = true
}
