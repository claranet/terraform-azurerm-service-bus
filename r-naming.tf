resource "azurecaf_name" "servicebus_namespace" {
  name          = var.stack
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "bus"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_queue" {
  for_each = toset(local.queues_list)

  name          = var.stack
  resource_type = "azurerm_servicebus_queue"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_queue_auth_rule_reader" {
  for_each = toset(local.queues_reader)

  name          = var.stack
  resource_type = "azurerm_servicebus_queue_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], "reader", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_queue_auth_rule_sender" {
  for_each = toset(local.queues_sender)

  name          = var.stack
  resource_type = "azurerm_servicebus_queue_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], "sender", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_queue_auth_rule_manage" {
  for_each = toset(local.queues_manage)

  name          = var.stack
  resource_type = "azurerm_servicebus_queue_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, split("|", each.key)[1], "manage", local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
