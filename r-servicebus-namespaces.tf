resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = coalesce(var.servicebus_namespace.custom_name, azurecaf_name.servicebus_namespace.result)
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                 = var.servicebus_namespace.sku
  capacity            = var.servicebus_namespace.sku != "Premium" ? 0 : var.servicebus_namespace.capacity
  local_auth_enabled  = var.servicebus_namespace.local_auth_enabled
  zone_redundant      = var.servicebus_namespace.sku != "Premium" ? false : var.servicebus_namespace.zone_redundant
  minimum_tls_version = var.servicebus_namespace.minimum_tls_version

  public_network_access_enabled = var.servicebus_namespace.public_network_access_enabled

  dynamic "identity" {
    for_each = var.identity_type == null ? [] : ["enabled"]
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids == "UserAssigned" ? var.identity_ids : null
    }
  }

  tags = merge(
    local.default_tags,
    var.extra_tags,
  )
}
