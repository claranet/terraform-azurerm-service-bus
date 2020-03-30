resource "azurerm_servicebus_queue_authorization_rule" "reader" {
  for_each            = toset(local.queues_reader)
  name                = "${split("|", each.key)[1]}-reader"
  namespace_name      = azurerm_servicebus_namespace.servicebus_namespace[split("|", each.key)[0]].name
  queue_name          = azurerm_servicebus_queue.queue[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "sender" {
  for_each            = toset(local.queues_sender)
  name                = "${split("|", each.key)[1]}-sender"
  namespace_name      = azurerm_servicebus_namespace.servicebus_namespace[split("|", each.key)[0]].name
  queue_name          = azurerm_servicebus_queue.queue[each.key].name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "manage" {
  for_each            = toset(local.queues_manage)
  name                = "${split("|", each.key)[1]}-manage"
  namespace_name      = azurerm_servicebus_namespace.servicebus_namespace[split("|", each.key)[0]].name
  queue_name          = azurerm_servicebus_queue.queue[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
