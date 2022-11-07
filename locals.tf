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
}
