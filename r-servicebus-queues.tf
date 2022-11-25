resource "azurerm_servicebus_queue" "queue" {
  for_each = local.queues

  name         = coalesce(each.value.custom_name, data.azurecaf_name.servicebus_queue[each.key].result)
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id

  status = each.value.status

  lock_duration                 = try(format("PT%sM", each.value.lock_duration_in_minutes), null)
  max_message_size_in_kilobytes = each.value.max_message_size_in_kilobytes
  max_size_in_megabytes         = each.value.max_size_in_megabytes
  requires_duplicate_detection  = each.value.requires_duplicate_detection
  requires_session              = each.value.requires_session
  default_message_ttl           = try(format("PT%sM", each.value.default_message_ttl_in_minutes), null)

  dead_lettering_on_message_expiration    = each.value.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = try(format("PT%sM", each.value.duplicate_detection_history_time_window), null)

  max_delivery_count        = each.value.max_delivery_count
  enable_batched_operations = each.value.enable_batched_operations
  auto_delete_on_idle       = try(format("PT%sM", each.value.auto_delete_on_idle), null)

  enable_partitioning = var.namespace_parameters.sku != "Premium" ? each.value.enable_partitioning : false
  enable_express      = var.namespace_parameters.sku != "Premium" ? each.value.enable_express : false

  forward_to                        = each.value.forward_to
  forward_dead_lettered_messages_to = each.value.forward_dead_lettered_messages_to
}
