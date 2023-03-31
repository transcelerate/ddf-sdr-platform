output "sb_id" {  
  value = azurerm_servicebus_namespace.servicebus.id
}

output "sbqueue_id" {
  value = azurerm_servicebus_queue.sbqueue.id
} 

output "sbqueue_authid" {
  value = azurerm_servicebus_queue_authorization_rule.sbqueueaccessrule.primary_connection_string
}

output "sbqueue_name" {
  
  value = azurerm_servicebus_queue.sbqueue.name

}

output "sbname" {
  value = azurerm_servicebus_namespace.servicebus.name
}

output "sbqueuearn" {
  
  value = azurerm_servicebus_queue_authorization_rule.sbqueueaccessrule.name
}

output "sbqueue_authidps" {
  value = azurerm_servicebus_queue_authorization_rule.sbqueueaccessrule.primary_key
}