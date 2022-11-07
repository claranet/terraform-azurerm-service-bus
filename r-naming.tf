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
  for_each = local.queues

  name          = var.stack
  resource_type = "azurerm_servicebus_queue"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_namespace_auth_rule" {
  for_each = toset(["listen", "send", "manage"])

  name          = var.stack
  resource_type = "azurerm_servicebus_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_topic" {
  for_each = local.topics

  name          = var.stack
  resource_type = "azurerm_servicebus_topic"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "servicebus_topic_sub" {
  for_each = local.subscriptions

  name          = var.stack
  resource_type = "azurerm_servicebus_subscription"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.value.sub_name, local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
