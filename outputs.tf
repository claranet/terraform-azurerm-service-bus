output "namespace" {
  description = "Service Bus Namespace outputs."
  value       = azurerm_servicebus_namespace.servicebus_namespace
}

output "namespace_listen_authorization_rule" {
  description = "Service Bus namespace listen only authorization rule"
  value       = try(azurerm_servicebus_namespace_authorization_rule.listen["enabled"], null)
}

output "namespace_send_authorization_rule" {
  description = "Service Bus namespace send only authorization rule"
  value       = try(azurerm_servicebus_namespace_authorization_rule.send["enabled"], null)
}

output "namespace_manage_authorization_rule" {
  description = "Service Bus namespace manage only authorization rule"
  value       = try(azurerm_servicebus_namespace_authorization_rule.manage["enabled"], null)
}

output "queues" {
  description = "Service Bus queues outputs."
  value       = { for q in var.servicebus_queues : q.name => azurerm_servicebus_queue.queue[q.name] }
}
