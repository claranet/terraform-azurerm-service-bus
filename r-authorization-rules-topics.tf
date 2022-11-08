resource "azurerm_servicebus_topic_authorization_rule" "listen" {
  for_each = {
    for a in local.topics_auth : format("%s.%s", a.topic, a.rule) => a if a.rule == "listen" && a.authorizations.listen
  }

  name     = var.use_caf_naming ? azurecaf_name.servicebus_topic_auth_rule[each.key].result : "listen-default"
  topic_id = azurerm_servicebus_topic.topic[each.value.topic].id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_topic_authorization_rule" "send" {
  for_each = {
    for a in local.topics_auth : format("%s.%s", a.topic, a.rule) => a if a.rule == "send" && a.authorizations.send
  }

  name     = var.use_caf_naming ? azurecaf_name.servicebus_topic_auth_rule[each.key].result : "send-default"
  topic_id = azurerm_servicebus_topic.topic[each.value.topic].id

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_topic_authorization_rule" "manage" {
  for_each = {
    for a in local.topics_auth : format("%s.%s", a.topic, a.rule) => a if a.rule == "manage" && a.authorizations.manage
  }

  name     = var.use_caf_naming ? azurecaf_name.servicebus_topic_auth_rule[each.key].result : "manage-default"
  topic_id = azurerm_servicebus_topic.topic[each.value.topic].id

  listen = true
  send   = true
  manage = true
}
