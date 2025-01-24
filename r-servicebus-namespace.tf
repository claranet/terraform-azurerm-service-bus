resource "azurerm_servicebus_namespace" "main" {
  name                = coalesce(var.namespace_parameters.custom_name, data.azurecaf_name.servicebus_namespace.result)
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                          = var.namespace_parameters.sku
  capacity                     = var.namespace_parameters.sku != "Premium" ? 0 : var.namespace_parameters.capacity
  premium_messaging_partitions = var.namespace_parameters.sku != "Premium" ? 0 : var.namespace_parameters.premium_messaging_partitions
  local_auth_enabled           = var.namespace_parameters.local_auth_enabled
  minimum_tls_version          = var.namespace_parameters.minimum_tls_version

  public_network_access_enabled = var.namespace_parameters.public_network_access_enabled

  dynamic "identity" {
    for_each = var.identity_type == null ? [] : ["enabled"]
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids == "UserAssigned" ? var.identity_ids : null
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rules_enabled == null ? [] : ["enabled"]
    content {
      default_action                = var.default_firewall_action
      public_network_access_enabled = var.namespace_parameters.public_network_access_enabled
      trusted_services_allowed      = var.trusted_services_allowed
      ip_rules                      = var.allowed_cidrs

      dynamic "network_rules" {
        for_each = var.subnet_ids != null ? var.subnet_ids : []
        iterator = subnet
        content {
          subnet_id                            = subnet.value
          ignore_missing_vnet_service_endpoint = false
        }
      }
    }
  }

  tags = merge(
    local.default_tags,
    var.extra_tags,
  )
}

moved {
  from = azurerm_servicebus_namespace.servicebus_namespace
  to   = azurerm_servicebus_namespace.main
}
