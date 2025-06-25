data "azurecaf_name" "servicebus_namespace" {
  name          = var.stack
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, "bus"])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_queue" {
  for_each = local.queues

  name          = var.stack
  resource_type = "azurerm_servicebus_queue"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_namespace_auth_rule" {
  for_each = toset(["listen", "send", "manage"])

  name          = var.stack
  resource_type = "azurerm_servicebus_namespace_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_topic" {
  for_each = local.topics

  name          = var.stack
  resource_type = "azurerm_servicebus_topic"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.key, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_topic_sub" {
  for_each = local.subscriptions

  name          = var.stack
  resource_type = "azurerm_servicebus_subscription"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.value.sub_name, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_topic_sub_rule" {
  for_each = local.subscription_rules

  name          = var.stack
  resource_type = "azurerm_servicebus_subscription_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.value.rule_name, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_queue_auth_rule" {
  for_each = { for a in local.queues_auth : format("%s.%s", a.queue, a.rule) => format("%s-%s", a.queue, a.rule) }

  name          = var.stack
  resource_type = "azurerm_servicebus_queue_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.value, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "servicebus_topic_auth_rule" {
  for_each = { for a in local.topics_auth : format("%s.%s", a.topic, a.rule) => format("%s-%s", a.topic, a.rule) }

  name          = var.stack
  resource_type = "azurerm_servicebus_topic_authorization_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, each.value, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}
