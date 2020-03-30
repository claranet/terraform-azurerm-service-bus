output "namespaces" {
  description = "Map of the namespaces"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => azurerm_servicebus_namespace.servicebus_namespace[namespace].id
  }
}

output "queues" {
  description = "Map of the queues"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_list :
    azurerm_servicebus_queue.queue[queue].name => azurerm_servicebus_queue.queue[queue].id if split("|", queue)[0] == namespace }
  }
}

output "senders" {
  description = "Map of the senders access policies"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_sender :
    azurerm_servicebus_queue_authorization_rule.sender[queue].name => azurerm_servicebus_queue_authorization_rule.sender[queue].primary_connection_string if split("|", queue)[0] == namespace }
  }
}

output "readers" {
  description = "Map of the readers access policies"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_reader :
    azurerm_servicebus_queue_authorization_rule.reader[queue].name => azurerm_servicebus_queue_authorization_rule.reader[queue].primary_connection_string if split("|", queue)[0] == namespace }
  }
}

output "manages" {
  description = "Map of the manages access policies"
  value = {
    for namespace, config in var.servicebus_namespaces_queues :
    namespace => { for queue in local.queues_manage :
    azurerm_servicebus_queue_authorization_rule.manage[queue].name => azurerm_servicebus_queue_authorization_rule.manage[queue].primary_connection_string if split("|", queue)[0] == namespace }
  }
}
