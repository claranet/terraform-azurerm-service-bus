output "namespace" {
  description = "Service Bus Namespace outputs."
  value       = azurerm_servicebus_namespace.servicebus_namespace
}

output "queues" {
  description = "Service Bus queues outputs."
  value       = { for q in var.servicebus_queues : q.name => azurerm_servicebus_queue.queue[q.name] }
}
