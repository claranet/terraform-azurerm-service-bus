output "resource" {
  description = "Service Bus Namespace outputs."
  value       = azurerm_servicebus_namespace.main
  sensitive   = true
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}

output "namespace_listen_authorization_rule" {
  description = "Service Bus namespace listen only authorization rule."
  value       = try(azurerm_servicebus_namespace_authorization_rule.listen["enabled"], null)
}

output "namespace_send_authorization_rule" {
  description = "Service Bus namespace send only authorization rule."
  value       = try(azurerm_servicebus_namespace_authorization_rule.send["enabled"], null)
}

output "namespace_manage_authorization_rule" {
  description = "Service Bus namespace manage authorization rule."
  value       = try(azurerm_servicebus_namespace_authorization_rule.manage["enabled"], null)
}

output "queues" {
  description = "Service Bus queues outputs."
  value       = { for q_name in keys(local.queues) : q_name => azurerm_servicebus_queue.main[q_name] }
}

output "topics" {
  description = "Service Bus topics outputs."
  value       = { for t_name in keys(local.topics) : t_name => azurerm_servicebus_topic.main[t_name] }
}

output "subscriptions" {
  description = "Service Bus topics subscriptions outputs."
  value       = { for s_name in keys(local.subscriptions) : s_name => azurerm_servicebus_subscription.main[s_name] }
}

output "queues_listen_authorization_rule" {
  description = "Service Bus queues listen only authorization rules."
  value = {
    for a in local.queues_auth :
    a.queue => azurerm_servicebus_queue_authorization_rule.listen[format("%s.%s", a.queue, a.rule)] if a.rule == "listen" && a.authorizations.listen
  }
  sensitive = true
}

output "queues_send_authorization_rule" {
  description = "Service Bus queues send only authorization rules."
  value = {
    for a in local.queues_auth :
    a.queue => azurerm_servicebus_queue_authorization_rule.send[format("%s.%s", a.queue, a.rule)] if a.rule == "send" && a.authorizations.send
  }
}

output "queues_manage_authorization_rule" {
  description = "Service Bus queues manage authorization rules."
  value = {
    for a in local.queues_auth :
    a.queue => azurerm_servicebus_queue_authorization_rule.manage[format("%s.%s", a.queue, a.rule)] if a.rule == "manage" && a.authorizations.manage
  }
  sensitive = true
}

output "topics_listen_authorization_rule" {
  description = "Service Bus topics listen only authorization rules."
  value = {
    for a in local.topics_auth :
    a.topic => azurerm_servicebus_topic_authorization_rule.listen[format("%s.%s", a.topic, a.rule)] if a.rule == "listen" && a.authorizations.listen
  }
  sensitive = true
}

output "topics_send_authorization_rule" {
  description = "Service Bus topics send only authorization rules."
  value = {
    for a in local.topics_auth :
    a.topic => azurerm_servicebus_topic_authorization_rule.send[format("%s.%s", a.topic, a.rule)] if a.rule == "send" && a.authorizations.send
  }
  sensitive = true
}

output "topics_manage_authorization_rule" {
  description = "Service Bus topics manage authorization rules."
  value = {
    for a in local.topics_auth :
    a.topic => azurerm_servicebus_topic_authorization_rule.manage[format("%s.%s", a.topic, a.rule)] if a.rule == "manage" && a.authorizations.manage
  }
}
