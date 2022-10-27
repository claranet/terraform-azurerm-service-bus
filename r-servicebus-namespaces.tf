resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  for_each            = var.servicebus_namespaces_queues
  name                = lookup(each.value, "custom_name", azurecaf_name.servicebus_namespace[each.key].result)
  location            = var.location
  resource_group_name = var.resource_group_name

  sku            = lookup(each.value, "sku", "Basic")
  capacity       = lookup(each.value, "capacity", lookup(each.value, "sku", "Basic") == "Premium" ? 1 : 0)
  zone_redundant = lookup(each.value, "zone_redundant", null)

  tags = merge(
    local.default_tags,
    var.extra_tags,
  )
}
