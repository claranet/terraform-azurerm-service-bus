resource "azurerm_servicebus_queue_authorization_rule" "listen" {
  for_each = {
    for a in local.queues_auth : format("%s.listen", a.queue) => a if a.rule == "listen" && a.authorizations.listen
  }

  name     = try(format("%s-listen", coalesce(each.value.authorizations_custom_name, each.value.custom_name)), var.use_caf_naming ? data.azurecaf_name.servicebus_queue_auth_rule[each.key].result : "listen-default")
  queue_id = azurerm_servicebus_queue.queue[each.value.queue].id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "send" {
  for_each = {
    for a in local.queues_auth : format("%s.send", a.queue) => a if a.rule == "send" && a.authorizations.send
  }

  name     = try(format("%s-send", coalesce(each.value.authorizations_custom_name, each.value.custom_name)), var.use_caf_naming ? data.azurecaf_name.servicebus_queue_auth_rule[each.key].result : "send-default")
  queue_id = azurerm_servicebus_queue.queue[each.value.queue].id

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "manage" {
  for_each = {
    for a in local.queues_auth : format("%s.manage", a.queue) => a if a.rule == "manage" && a.authorizations.manage
  }

  name     = try(format("%s-manage", coalesce(each.value.authorizations_custom_name, each.value.custom_name)), var.use_caf_naming ? data.azurecaf_name.servicebus_queue_auth_rule[each.key].result : "manage-default")
  queue_id = azurerm_servicebus_queue.queue[each.value.queue].id

  listen = true
  send   = true
  manage = true
}
