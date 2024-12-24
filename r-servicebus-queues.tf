resource "azurerm_servicebus_queue" "main" {
  for_each = local.queues

  name         = coalesce(each.value.custom_name, data.azurecaf_name.servicebus_queue[each.key].result)
  namespace_id = azurerm_servicebus_namespace.main.id

  status = each.value.status

  lock_duration                 = try(format("PT%sM", tonumber(each.value.lock_duration)), each.value.lock_duration)
  max_message_size_in_kilobytes = each.value.max_message_size_in_kilobytes
  max_size_in_megabytes         = each.value.max_size_in_megabytes
  requires_duplicate_detection  = each.value.requires_duplicate_detection
  requires_session              = each.value.requires_session
  default_message_ttl           = try(format("PT%sM", tonumber(each.value.default_message_ttl)), each.value.default_message_ttl)

  dead_lettering_on_message_expiration    = each.value.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = try(format("PT%sM", tonumber(each.value.duplicate_detection_history_time_window)), each.value.duplicate_detection_history_time_window)

  max_delivery_count         = each.value.max_delivery_count
  batched_operations_enabled = each.value.batched_operations_enabled
  auto_delete_on_idle        = try(format("PT%sM", tonumber(each.value.auto_delete_on_idle)), each.value.auto_delete_on_idle)

  partitioning_enabled = var.namespace_parameters.sku != "Premium" ? each.value.partitioning_enabled : false
  express_enabled      = var.namespace_parameters.sku != "Premium" ? each.value.express_enabled : false

  forward_to                        = each.value.forward_to
  forward_dead_lettered_messages_to = each.value.forward_dead_lettered_messages_to
}

moved {
  from = azurerm_servicebus_queue.queue
  to   = azurerm_servicebus_queue.main
}
