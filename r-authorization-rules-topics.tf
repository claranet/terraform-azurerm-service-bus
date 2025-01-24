resource "azurerm_servicebus_topic_authorization_rule" "listen" {
  for_each = {
    for a in local.topics_auth : format("%s.listen", a.topic) => a if a.rule == "listen" && a.authorizations.listen
  }

  name     = try(format("%s-listen", coalesce(each.value.authorizations_custom_name, each.value.custom_name)), data.azurecaf_name.servicebus_topic_auth_rule[each.key].result)
  topic_id = azurerm_servicebus_topic.main[each.value.topic].id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_topic_authorization_rule" "send" {
  for_each = {
    for a in local.topics_auth : format("%s.send", a.topic) => a if a.rule == "send" && a.authorizations.send
  }

  name     = try(format("%s-send", coalesce(each.value.authorizations_custom_name, each.value.custom_name)), data.azurecaf_name.servicebus_topic_auth_rule[each.key].result)
  topic_id = azurerm_servicebus_topic.main[each.value.topic].id

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_topic_authorization_rule" "manage" {
  for_each = {
    for a in local.topics_auth : format("%s.manage", a.topic) => a if a.rule == "manage" && a.authorizations.manage
  }

  name     = try(format("%s-manage", coalesce(each.value.authorizations_custom_name, each.value.custom_name)), data.azurecaf_name.servicebus_topic_auth_rule[each.key].result)
  topic_id = azurerm_servicebus_topic.main[each.value.topic].id

  listen = true
  send   = true
  manage = true
}
