output "namespaces" {
  description = "Service Bus namespaces map"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => azurerm_servicebus_namespace.servicebus_namespace[namespace]
  }
}

output "queues" {
  description = "Service Bus queues map"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_list :
    azurerm_servicebus_queue.queue[queue].name => azurerm_servicebus_queue.queue[queue] if split("|", queue)[0] == namespace }
  }
}

output "senders" {
  description = "Service Bus \"sender\" authorization rules map"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_sender :
    azurerm_servicebus_queue_authorization_rule.sender[queue].name => azurerm_servicebus_queue_authorization_rule.sender[queue] if split("|", queue)[0] == namespace }
  }
}

output "readers" {
  description = "Service Bus \"readers\" authorization rules map"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_reader :
    azurerm_servicebus_queue_authorization_rule.reader[queue].name => azurerm_servicebus_queue_authorization_rule.reader[queue] if split("|", queue)[0] == namespace }
  }
}

output "manages" {
  description = "Service Bus \"managers\" authorization rules map"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_manage :
    azurerm_servicebus_queue_authorization_rule.manage[queue].name => azurerm_servicebus_queue_authorization_rule.manage[queue] if split("|", queue)[0] == namespace }
  }
}
