locals {
  default_tags = {
    env   = var.environment
    stack = var.stack
  }

  # Generate prefix and add "-sb" suffix
  default_name = "${var.stack}-${var.client_name}-${var.location_short}-${var.environment}"

  queues_list = flatten([
    for namespace, queues in var.queues : [
      for queuename in queues : [
        "${namespace}|${queuename}"
      ]
    ]
  ])
}
