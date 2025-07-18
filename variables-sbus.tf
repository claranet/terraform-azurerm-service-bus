variable "namespace_parameters" {
  description = <<EOD
Object to handle Service Bus Namespace options.
```
custom_name         = To override default resource name, generated if not set.
sku                 = Defines which tier to use. Options are `Basic`, `Standard` or `Premium`.
capacity            = Specifies the capacity. When SKU is `Premium`, capacity can be 1, 2, 4, 8 or 16.
premium_messaging_partitions            = Specifies the number messaging partitions. Only valid when sku is Premium and the minimum number is 1. Possible values include 0, 1, 2, and 4. Changing this forces a new resource to be created.
local_auth_enabled  = Whether or not SAS authentication is enabled for the Service Bus Namespace.
minimum_tls_version = The minimum supported TLS version for this Service Bus Namespace.

public_network_access_enabled = Is public network access enabled for the Service Bus Namespace?
```
EOD
  type = object({
    custom_name                  = optional(string)
    sku                          = optional(string, "Standard")
    capacity                     = optional(number, 0)
    premium_messaging_partitions = optional(number, 0)
    local_auth_enabled           = optional(bool, true)
    minimum_tls_version          = optional(string, "1.2")

    public_network_access_enabled = optional(bool, true)
  })
  default = {}
}

variable "namespace_authorizations" {
  description = "Object to specify which Namespace Authorization Rules need to be created."
  type = object({
    listen = optional(bool, true)
    send   = optional(bool, true)
    manage = optional(bool, true)
  })
  default = {}
}

variable "servicebus_queues" {
  description = <<EOD
List of objects to create Queues with their options.
```
name        = Short Queue name.
custom_name = Custom name for Azure resource.

status = The status of the Queue. Possible values are `Active`, `Creating`, `Deleting`, `Disabled`, `ReceiveDisabled`, `Renaming`, `SendDisabled`, `Unknown`. Note that `Restoring` is not accepted.

auto_delete_on_idle                     = Duration of the idle interval after which the Queue is automatically deleted.
default_message_ttl                     = Duration of the TTL of messages sent to this Queue.
duplicate_detection_history_time_window = Duration during which duplicates can be detected.
lock_duration                           = Duration of a peek-lock that is, the amount of time that the message is locked for other receivers. Maximum value is 5 minutes.
max_message_size_in_kilobytes           = Integer value which controls the maximum size of a message allowed on the Queue for Premium SKU.
max_size_in_megabytes                   = Integer value which controls the size of memory allocated for the Queue.
max_delivery_count                      = Integer value which controls when a message is automatically dead lettered.

batched_operations_enabled            = Boolean flag which controls whether server-side batched operations are enabled.
partitioning_enabled                  = Boolean flag which controls whether to enable the Queue to be partitioned across multiple message brokers. Partitioning is available at entity creation for all Queues and Topics in Basic or Standard SKUs.
express_enabled                       = Boolean flag which controls whether Express Entities are enabled. An express Queue holds a message in memory temporarily before writing it to persistent storage.
dead_lettering_on_message_expiration = Boolean flag which controls whether the Queue has dead letter support when a message expires.
requires_duplicate_detection         = Boolean flag which controls whether the Queue requires duplicate detection.
requires_session                     = Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a Queue can guarantee first-in-first-out delivery of messages.

forward_to                        = The name of a Queue or Topic to automatically forward messages to.
forward_dead_lettered_messages_to = The name of a Queue or Topic to automatically forward dead lettered messages to.

authorizations_custom_name = To override default Queue Authorization Rules names, generated if not set (first with the custom name of the Queue if set, otherwise with Azure CAF).
authorizations             = Object with `listen`, `send` and `manage` attributes to create Queues Authorizations Rules.
```
EOD
  type = list(object({
    name        = string
    custom_name = optional(string)

    status = optional(string, "Active")

    auto_delete_on_idle                     = optional(string)
    default_message_ttl                     = optional(string)
    duplicate_detection_history_time_window = optional(string)
    lock_duration                           = optional(string)
    max_message_size_in_kilobytes           = optional(number)
    max_size_in_megabytes                   = optional(number)
    max_delivery_count                      = optional(number, 10)

    batched_operations_enabled           = optional(bool, true)
    partitioning_enabled                 = optional(bool)
    express_enabled                      = optional(bool)
    dead_lettering_on_message_expiration = optional(bool)
    requires_duplicate_detection         = optional(bool)
    requires_session                     = optional(bool)

    forward_to                        = optional(string)
    forward_dead_lettered_messages_to = optional(string)

    authorizations_custom_name = optional(string)
    authorizations = optional(object({
      listen = optional(bool, true)
      send   = optional(bool, true)
      manage = optional(bool, true)
    }), {})
  }))
  default = []
}

variable "servicebus_topics" {
  description = <<EOD
List of objects to create Topics with their options.
```
name        = Short Topic name.
custom_name = Custom name for Azure resource.

status = The status of the Service Bus Topic. Acceptable values are `Active` or `Disabled`.

auto_delete_on_idle                     = Duration of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes.
default_message_ttl                     = Duration of TTL of messages sent to this Topic if no TTL value is set on the message itself.
duplicate_detection_history_time_window = Duration during which duplicates can be detected.
max_message_size_in_kilobytes           = Integer value which controls the maximum size of a message allowed on the Topic for `Premium` SKU.
max_size_in_megabytes                   = Integer value which controls the size of memory allocated for the Topic.

batched_operations_enabled    = Boolean flag which controls if server-side batched operations are enabled.
partitioning_enabled          = Boolean flag which controls whether to enable the Topic to be partitioned across multiple message brokers.
express_enabled               = Boolean flag which controls whether Express Entities are enabled. An express Topic holds a message in memory temporarily before writing it to persistent storage.
requires_duplicate_detection = Boolean flag which controls whether the Topic requires duplicate detection.
support_ordering             = Boolean flag which controls whether the Topic supports ordering.

authorizations_custom_name = To override default Topic Authorization Rules names, generated if not set (first with the custom name of the Topic if set, otherwise with Azure CAF).
authorizations             = Object with `listen`, `send` and `manage` attributes to create Topics Authorizations Rules.

subscriptions = List of subscriptions per Topic.
```
EOD
  type = list(object({
    name        = string
    custom_name = optional(string)

    status = optional(string, "Active")

    auto_delete_on_idle                     = optional(string)
    default_message_ttl                     = optional(string)
    duplicate_detection_history_time_window = optional(string)
    max_message_size_in_kilobytes           = optional(number)
    max_size_in_megabytes                   = optional(number)

    batched_operations_enabled   = optional(bool)
    partitioning_enabled         = optional(bool)
    express_enabled              = optional(bool)
    requires_duplicate_detection = optional(bool)
    support_ordering             = optional(bool)

    authorizations_custom_name = optional(string)
    authorizations = optional(object({
      listen = optional(bool, true)
      send   = optional(bool, true)
      manage = optional(bool, true)
    }), {})

    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription
    subscriptions = optional(list(object({
      name        = string
      custom_name = optional(string)

      status = optional(string, "Active")

      auto_delete_on_idle = optional(string)
      default_message_ttl = optional(string)
      lock_duration       = optional(string)
      max_delivery_count  = number

      batched_operations_enabled                = optional(bool, true)
      dead_lettering_on_message_expiration      = optional(bool)
      dead_lettering_on_filter_evaluation_error = optional(bool)
      requires_session                          = optional(bool)

      forward_to                        = optional(string)
      forward_dead_lettered_messages_to = optional(string)

      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule
      rules = optional(list(object({
        name        = string
        custom_name = optional(string)

        filter_type = optional(string, "SqlFilter")
        sql_filter  = optional(string)
        correlation_filter = optional(object({
          correlation_id      = optional(string)
          content_type        = optional(string)
          label               = optional(string)
          reply_to            = optional(string)
          reply_to_session_id = optional(string)
          session_id          = optional(string)
          to                  = optional(string)
          properties          = optional(map(string))
        }))
        action_type = optional(string)
      })), [])
    })), [])
  }))
  default = []
}
