resource "azurerm_servicebus_namespace_authorization_rule" "listen" {
  for_each = toset(var.namespace_authorizations.listen ? ["enabled"] : [])

  name         = var.use_caf_naming ? azurecaf_name.servicebus_namespace_auth_rule["listen"].result : "listen-default"
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_namespace_authorization_rule" "send" {
  for_each = toset(var.namespace_authorizations.send ? ["enabled"] : [])

  name         = var.use_caf_naming ? azurecaf_name.servicebus_namespace_auth_rule["send"].result : "send-default"
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_namespace_authorization_rule" "manage" {
  for_each = toset(var.namespace_authorizations.manage ? ["enabled"] : [])

  name         = var.use_caf_naming ? azurecaf_name.servicebus_namespace_auth_rule["manage"].result : "manage-default"
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  listen = true
  send   = true
  manage = true
}
