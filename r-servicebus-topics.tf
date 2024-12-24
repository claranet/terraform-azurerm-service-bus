resource "azurerm_servicebus_topic" "main" {
  for_each = local.topics

  name         = coalesce(each.value.custom_name, data.azurecaf_name.servicebus_topic[each.key].result)
  namespace_id = azurerm_servicebus_namespace.main.id

  status = each.value.status

  auto_delete_on_idle = try(format("PT%sM", tonumber(each.value.auto_delete_on_idle)), each.value.auto_delete_on_idle)
  default_message_ttl = try(format("PT%sM", tonumber(each.value.default_message_ttl)), each.value.default_message_ttl)

  duplicate_detection_history_time_window = try(format("PT%sM", tonumber(each.value.duplicate_detection_history_time_window)), each.value.duplicate_detection_history_time_window)

  batched_operations_enabled = each.value.batched_operations_enabled
  express_enabled            = each.value.express_enabled
  partitioning_enabled       = var.namespace_parameters.sku != "Premium" ? each.value.partitioning_enabled : null

  max_message_size_in_kilobytes = var.namespace_parameters.sku != "Premium" ? null : each.value.max_message_size_in_kilobytes
  max_size_in_megabytes         = each.value.max_size_in_megabytes
  requires_duplicate_detection  = each.value.requires_duplicate_detection
  support_ordering              = each.value.support_ordering
}

moved {
  from = azurerm_servicebus_topic.topic
  to   = azurerm_servicebus_topic.main
}
