resource "azurerm_servicebus_namespace_authorization_rule" "listen" {
  for_each = toset(var.namespace_authorizations.listen ? ["enabled"] : [])

  name         = data.azurecaf_name.servicebus_namespace_auth_rule["listen"].result
  namespace_id = azurerm_servicebus_namespace.main.id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_namespace_authorization_rule" "send" {
  for_each = toset(var.namespace_authorizations.send ? ["enabled"] : [])

  name         = data.azurecaf_name.servicebus_namespace_auth_rule["send"].result
  namespace_id = azurerm_servicebus_namespace.main.id

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_namespace_authorization_rule" "manage" {
  for_each = toset(var.namespace_authorizations.manage ? ["enabled"] : [])

  name         = data.azurecaf_name.servicebus_namespace_auth_rule["manage"].result
  namespace_id = azurerm_servicebus_namespace.main.id

  listen = true
  send   = true
  manage = true
}
