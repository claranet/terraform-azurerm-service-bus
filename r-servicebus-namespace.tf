resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = coalesce(var.namespace_parameters.custom_name, data.azurecaf_name.servicebus_namespace.result)
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                 = var.namespace_parameters.sku
  capacity            = var.namespace_parameters.sku != "Premium" ? 0 : var.namespace_parameters.capacity
  local_auth_enabled  = var.namespace_parameters.local_auth_enabled
  zone_redundant      = var.namespace_parameters.sku != "Premium" ? false : var.namespace_parameters.zone_redundant
  minimum_tls_version = var.namespace_parameters.minimum_tls_version

  public_network_access_enabled = var.namespace_parameters.public_network_access_enabled

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
