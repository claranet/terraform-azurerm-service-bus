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

  queues_auth = flatten([
    for q_name, q in local.queues : [
      for rule in ["listen", "send", "manage"] : {
        queue          = q_name
        rule           = rule
        custom_name    = q.custom_name
        authorizations = q.authorizations
      }
    ]
  ])
  topics_auth = flatten([
    for t_name, t in local.topics : [
      for rule in ["listen", "send", "manage"] : {
        topic          = t_name
        rule           = rule
        authorizations = t.authorizations
      }
    ]
  ])
}
