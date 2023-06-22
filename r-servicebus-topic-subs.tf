resource "azurerm_servicebus_subscription" "topic_sub" {
  for_each = local.subscriptions

  name     = coalesce(each.value.sub_conf.custom_name, data.azurecaf_name.servicebus_topic_sub[each.key].result)
  topic_id = azurerm_servicebus_topic.topic[each.value.topic_name].id

  max_delivery_count = each.value.sub_conf.max_delivery_count
  status             = each.value.sub_conf.status

  auto_delete_on_idle       = each.value.sub_conf.auto_delete_on_idle
  enable_batched_operations = each.value.sub_conf.enable_batched_operations
  requires_session          = each.value.sub_conf.requires_session
  default_message_ttl       = try(format("PT%sM", tonumber(each.value.default_message_ttl)), each.value.default_message_ttl)
  lock_duration             = try(format("PT%sM", tonumber(each.value.lock_duration)), each.value.lock_duration)

  dead_lettering_on_message_expiration      = each.value.sub_conf.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error = each.value.sub_conf.dead_lettering_on_filter_evaluation_error

  forward_to                        = each.value.sub_conf.forward_to
  forward_dead_lettered_messages_to = each.value.sub_conf.forward_dead_lettered_messages_to
}
