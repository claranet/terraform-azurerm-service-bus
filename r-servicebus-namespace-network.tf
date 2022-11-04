resource "azurerm_servicebus_namespace_network_rule_set" "network_rules" {
  count = var.network_rules_enabled ? 1 : 0

  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  default_action                = var.default_firewall_action
  public_network_access_enabled = var.namespace_parameters.public_network_access_enabled
  trusted_services_allowed      = var.trusted_services_allowed

  dynamic "network_rules" {
    for_each = var.subnet_ids != null ? var.subnet_ids : []
    iterator = subnet
    content {
      subnet_id                            = subnet.value
      ignore_missing_vnet_service_endpoint = false
    }
  }

  ip_rules = var.allowed_cidrs
}
