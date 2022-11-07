resource "azurerm_servicebus_topic" "topic" {
  for_each = { for t in var.servicebus_topics : t.name => t }

  name         = coalesce(each.value.custom_name, azurecaf_name.servicebus_topic[each.key].result)
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  status = each.value.status

  auto_delete_on_idle = each.value.auto_delete_on_idle != null ? format("PT%sM", each.value.auto_delete_on_idle) : null
  default_message_ttl = each.value.default_message_ttl != null ? format("PT%sM", each.value.default_message_ttl) : null

  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window != null ? format("PT%sM", each.value.duplicate_detection_history_time_window) : null

  enable_batched_operations = each.value.enable_batched_operations
  enable_express            = each.value.enable_express
  enable_partitioning       = var.namespace_parameters.sku != "Premium" ? each.value.enable_partitioning : null

  max_message_size_in_kilobytes = var.namespace_parameters.sku != "Premium" ? null : each.value.max_message_size_in_kilobytes
  max_size_in_megabytes         = each.value.max_size_in_megabytes
  requires_duplicate_detection  = each.value.requires_duplicate_detection
  support_ordering              = each.value.support_ordering
}
