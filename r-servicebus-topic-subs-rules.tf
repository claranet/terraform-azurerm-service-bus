resource "azurerm_servicebus_subscription_rule" "main" {
  for_each = local.subscription_rules

  name            = coalesce(each.value.rule_conf.custom_name, data.azurecaf_name.servicebus_topic_sub_rule[each.key].result)
  subscription_id = azurerm_servicebus_subscription.main["${each.value.topic_name}.${each.value.sub_name}"].id
  filter_type     = each.value.rule_conf.filter_type

  # SQL Filter
  sql_filter = each.value.rule_conf.filter_type == "SqlFilter" ? each.value.rule_conf.sql_filter : null

  # Correlation Filter
  dynamic "correlation_filter" {
    for_each = each.value.rule_conf.filter_type == "CorrelationFilter" && each.value.rule_conf.correlation_filter != null ? [1] : []
    content {
      correlation_id      = each.value.rule_conf.correlation_filter.correlation_id
      content_type        = each.value.rule_conf.correlation_filter.content_type
      label               = each.value.rule_conf.correlation_filter.label
      reply_to            = each.value.rule_conf.correlation_filter.reply_to
      reply_to_session_id = each.value.rule_conf.correlation_filter.reply_to_session_id
      session_id          = each.value.rule_conf.correlation_filter.session_id
      to                  = each.value.rule_conf.correlation_filter.to

      # Properties are directly set as a map, not as a dynamic block
      properties = each.value.rule_conf.correlation_filter.properties
    }
  }

  # Action - only set if action_type is provided
  action = each.value.rule_conf.action_type != null ? each.value.rule_conf.action_type : null
}
