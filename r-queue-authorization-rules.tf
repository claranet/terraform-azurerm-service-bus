resource "azurerm_servicebus_queue_authorization_rule" "reader" {
  for_each = toset(local.queues_reader)
  name     = var.use_caf_naming ? azurecaf_name.servicebus_queue_auth_rule_reader[each.key].result : "${split("|", each.key)[1]}-reader"
  queue_id = azurerm_servicebus_queue.queue[each.key].id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "sender" {
  for_each = toset(local.queues_sender)
  name     = var.use_caf_naming ? azurecaf_name.servicebus_queue_auth_rule_sender[each.key].result : "${split("|", each.key)[1]}-sender"
  queue_id = azurerm_servicebus_queue.queue[each.key].id

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "manage" {
  for_each = toset(local.queues_manage)
  name     = var.use_caf_naming ? azurecaf_name.servicebus_queue_auth_rule_manage[each.key].result : "${split("|", each.key)[1]}-manage"
  queue_id = azurerm_servicebus_queue.queue[each.key].id

  listen = true
  send   = true
  manage = true
}
