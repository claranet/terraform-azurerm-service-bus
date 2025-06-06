locals {
  queues = try({ for q in var.servicebus_queues : q.name => q }, {})
  topics = try({ for t in var.servicebus_topics : t.name => t }, {})

  topics_subs = flatten([
    for topic in local.topics : [
      for sub in try(topic.subscriptions, {}) : {
        topic_name = topic.name
        sub_name   = sub.name
        sub_conf   = sub
      }
    ]
  ])
  subscriptions = { for sub in local.topics_subs : "${sub.topic_name}.${sub.sub_name}" => sub }

  # Flatten subscription rules for easier access
  topics_subs_rules = flatten([
    for topic in local.topics : [
      for sub in try(topic.subscriptions, []) : [
        for rule in try(sub.rules, []) : {
          topic_name = topic.name
          sub_name   = sub.name
          rule_name  = rule.name
          rule_conf  = rule
        }
      ]
    ]
  ])
  subscription_rules = { for rule in local.topics_subs_rules : "${rule.topic_name}.${rule.sub_name}.${rule.rule_name}" => rule }

  queues_auth = flatten([
    for q_name, q in local.queues : [
      for rule in ["listen", "send", "manage"] : {
        queue                      = q_name
        rule                       = rule
        custom_name                = q.custom_name
        authorizations_custom_name = q.authorizations_custom_name
        authorizations             = q.authorizations
      }
    ]
  ])
  topics_auth = flatten([
    for t_name, t in local.topics : [
      for rule in ["listen", "send", "manage"] : {
        topic                      = t_name
        rule                       = rule
        custom_name                = t.custom_name
        authorizations_custom_name = t.authorizations_custom_name
        authorizations             = t.authorizations
      }
    ]
  ])
}
