resource "azurerm_servicebus_queue" "queue" {
  for_each            = toset(local.servicebus_list)
  name                = split("|", each.key)[1]
  resource_group_name = var.rg_name
  namespace_name      = azurerm_servicebus_namespace.message_bus[split("|", each.key)[0]].name

  enable_partitioning                  = true
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  default_message_ttl                  = var.default_message_ttl
}
