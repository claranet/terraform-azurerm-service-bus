# Azure Service Bus feature
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/service-bus/azurerm/)

This Terraform module creates an [Azure Service Bus](https://docs.microsoft.com/en-us/azure/service-bus/).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

data "azurerm_subnet" "example" {
  name                 = "backend"
  virtual_network_name = "production"
  resource_group_name  = module.rg.resource_group_name
}

module "servicebus" {
  source  = "claranet/service-bus/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  namespace_parameters = {
    sku = "Premium"
  }

  namespace_authorizations = {
    listen = true
    send   = false
  }

  # Network rules
  network_rules_enabled    = true
  trusted_services_allowed = true
  allowed_cidrs = [
    "1.2.3.4/32",
  ]
  subnet_ids = [
    data.azurerm_subnet.example.id,
  ]

  servicebus_queues = [{
    name                = "myqueue"
    default_message_ttl = 5 # 5min

    dead_lettering_on_message_expiration = true
  }]

  servicebus_topics = [{
    name                = "mytopic"
    default_message_ttl = 5 # 5min

    subscriptions = [{
      name = "mainsub"

      max_delivery_count        = 10
      enable_batched_operations = true
      lock_duration             = 1 # 1 min
    }]
  }]

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.1 |
| azurerm | ~> 3.28 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | 6.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.servicebus_namespace](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.servicebus_namespace_auth_rule](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.servicebus_queue](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.servicebus_topic](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.servicebus_topic_sub](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_servicebus_namespace.servicebus_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |
| [azurerm_servicebus_namespace_authorization_rule.listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule) | resource |
| [azurerm_servicebus_namespace_authorization_rule.manage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule) | resource |
| [azurerm_servicebus_namespace_authorization_rule.send](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule) | resource |
| [azurerm_servicebus_namespace_network_rule_set.network_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_network_rule_set) | resource |
| [azurerm_servicebus_queue.queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) | resource |
| [azurerm_servicebus_subscription.topic_sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) | resource |
| [azurerm_servicebus_topic.topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidrs | List of CIDR to allow access to that Service Bus Namespace. | `list(string)` | `[]` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| default\_firewall\_action | Which default firewalling policy to apply. Valid values are `Allow` or `Deny`. | `string` | `"Deny"` | no |
| default\_tags\_enabled | Option to enable or disable default tags | `bool` | `true` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| identity\_ids | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Service Bus. | `list(string)` | `null` | no |
| identity\_type | Specifies the type of Managed Service Identity that should be configured on this Service Bus. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both). | `string` | `"SystemAssigned"` | no |
| location | Azure location for Servicebus. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources Ids for logs diagnostics destination. Can be Storage Account, Log Analytics Workspace and Event Hub. No more than one of each can be set. Empty list to disable logging. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| logs\_retention\_days | Number of days to keep logs on storage account | `number` | `30` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| namespace\_authorizations | Object to specify which Namespace authorizations need to be created. | <pre>object({<br>    listen = optional(bool, true)<br>    send   = optional(bool, true)<br>    manage = optional(bool, true)<br>  })</pre> | `{}` | no |
| namespace\_parameters | Object to handle Service Bus Namespace options.<pre>custom_name         = To override default resource name, generated if not set.<br>sku                 = Defines which tier to use. Options are `Basic`, `Standard` or `Premium`.<br>capacity            = Specifies the capacity. When SKU is `Premium`, capacity can be 1, 2, 4, 8 or 16.<br>local_auth_enabled  = Whether or not SAS authentication is enabled for the Service Bus namespace.<br>zone_redundant      = Whether or not this resource is zone redundant. SKU needs to be `Premium`.<br>minimum_tls_version = The minimum supported TLS version for this Service Bus Namespace.<br>public_network_access_enabled = Is public network access enabled for the Service Bus Namespace?</pre> | <pre>object({<br>    custom_name         = optional(string)<br>    sku                 = optional(string, "Standard")<br>    capacity            = optional(number, 0)<br>    local_auth_enabled  = optional(bool, true)<br>    zone_redundant      = optional(bool, false)<br>    minimum_tls_version = optional(string, "1.2")<br><br>    public_network_access_enabled = optional(bool, true)<br>  })</pre> | `{}` | no |
| network\_rules\_enabled | Boolean to enable Network Rules on the Service Bus Namespace, requires `trusted_services_allowed`, `allowed_cidrs`, `subnet_ids` or `default_firewall_action` correctly set if enabled. | `bool` | `false` | no |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| servicebus\_queues | List of objects to create queues with their options.<pre>name          = Short queue name.<br>custom_name   = Custom name for Azure resource.<br>lock_duration_in_minutes = Duration of a peek-lock (in minutes); that is, the amount of time that the message is locked for other receivers. Maximum value is 5 minutes.<br><br>max_message_size_in_kilobytes = Integer value which controls the maximum size of a message allowed on the queue for Premium SKU.<br>max_size_in_megabytes         = Integer value which controls the size of memory allocated for the queue.<br>max_delivery_count            = Integer value which controls when a message is automatically dead lettered.<br>requires_duplicate_detection  = Boolean flag which controls whether the Queue requires duplicate detection.<br>requires_session              = Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages.<br>default_message_ttl_in_minutes_in_minutes = Duration in minutes of the TTL of messages sent to this queue.<br><br>status = The status of the Queue. Possible values are `Active`, `Creating`, `Deleting`, `Disabled`, `ReceiveDisabled`, `Renaming`, `SendDisabled`, `Unknown`. Note that Restoring is not accepted.<br><br>dead_lettering_on_message_expiration    = Boolean flag which controls whether the Queue has dead letter support when a message expires.<br>duplicate_detection_history_time_window = Duration in minutes during which duplicates can be detected.<br><br>enable_batched_operations = Boolean flag which controls whether server-side batched operations are enabled.<br>auto_delete_on_idle       = Duration in minutes of the idle interval after which the Queue is automatically deleted.<br>enable_partitioning       = Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers. Partitioning is available at entity creation for all queues and topics in Basic or Standard SKUs.<br>enable_express            = Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage.<br><br>forward_to                        = The name of a Queue or Topic to automatically forward messages to.<br>forward_dead_lettered_messages_to = The name of a Queue or Topic to automatically forward dead lettered messages to.</pre> | <pre>list(object({<br>    name                                      = string<br>    custom_name                               = optional(string)<br>    lock_duration_in_minutes                  = optional(number, 1)<br>    max_message_size_in_kilobytes             = optional(number)<br>    max_size_in_megabytes                     = optional(number)<br>    max_delivery_count                        = optional(number, 10)<br>    requires_duplicate_detection              = optional(bool)<br>    requires_session                          = optional(bool)<br>    default_message_ttl_in_minutes_in_minutes = optional(number)<br><br>    status = optional(string, "Active")<br><br>    dead_lettering_on_message_expiration    = optional(bool)<br>    duplicate_detection_history_time_window = optional(number, 10)<br><br>    enable_batched_operations = optional(bool, true)<br>    auto_delete_on_idle       = optional(number)<br>    enable_partitioning       = optional(bool)<br>    enable_express            = optional(bool)<br><br>    forward_to                        = optional(string)<br>    forward_dead_lettered_messages_to = optional(string)<br>  }))</pre> | `[]` | no |
| servicebus\_topics | List of objects to create topics with their options.<pre>name          = Short topic name.<br>custom_name   = Custom name for Azure resource.<br>status        = The Status of the Service Bus Topic. Acceptable values are `Active` or `Disabled`.<br><br>auto_delete_on_idle = Duration in minutes of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes.<br>default_message_ttl_in_minutes = Duration in minutes of TTL of messages sent to this topic if no TTL value is set on the message itself.<br>duplicate_detection_history_time_window = Duration in minutes during which duplicates can be detected.<br><br>enable_batched_operations = Boolean flag which controls if server-side batched operations are enabled.<br>enable_express            = Boolean flag which controls whether Express Entities are enabled. An express topic holds a message in memory temporarily before writing it to persistent storage.<br>enable_partitioning       = Boolean flag which controls whether to enable the topic to be partitioned across multiple message brokers.<br><br>max_message_size_in_kilobytes = Integer value which controls the maximum size of a message allowed on the topic for `Premium` SKU.<br>max_size_in_megabytes         = Integer value which controls the size of memory allocated for the topic.<br>requires_duplicate_detection  = Boolean flag which controls whether the Topic requires duplicate detection.<br>support_ordering              = Boolean flag which controls whether the Topic supports ordering.<br><br>subscriptions = List of subscriptions per topic</pre> | <pre>list(object({<br>    name        = string<br>    custom_name = optional(string)<br><br>    status = optional(string, "Active")<br><br>    auto_delete_on_idle            = optional(number)<br>    default_message_ttl_in_minutes = optional(number)<br><br>    duplicate_detection_history_time_window = optional(number, 10)<br><br>    enable_batched_operations = optional(bool)<br>    enable_express            = optional(bool)<br>    enable_partitioning       = optional(bool)<br><br>    max_message_size_in_kilobytes = optional(number)<br>    max_size_in_megabytes         = optional(number)<br>    requires_duplicate_detection  = optional(bool)<br>    support_ordering              = optional(bool)<br><br>    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription<br>    subscriptions = optional(list(object({<br>      name        = string<br>      custom_name = optional(string)<br><br>      max_delivery_count = number<br><br>      status = optional(string, "Active")<br><br>      auto_delete_on_idle            = optional(number)<br>      enable_batched_operations      = optional(bool, true)<br>      requires_session               = optional(bool)<br>      default_message_ttl_in_minutes = optional(number)<br>      lock_duration                  = optional(number, 1)<br><br>      dead_lettering_on_message_expiration      = optional(bool)<br>      dead_lettering_on_filter_evaluation_error = optional(bool)<br><br>      forward_to                        = optional(string)<br>      forward_dead_lettered_messages_to = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| stack | Project stack name | `string` | n/a | yes |
| subnet\_ids | Subnets to allow access to that Service Bus Namespace. | `list(string)` | `[]` | no |
| trusted\_services\_allowed | If True, then Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration. | `bool` | `true` | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace | Service Bus Namespace outputs. |
| namespace\_listen\_authorization\_rule | Service Bus namespace listen only authorization rule |
| namespace\_manage\_authorization\_rule | Service Bus namespace manage only authorization rule |
| namespace\_send\_authorization\_rule | Service Bus namespace send only authorization rule |
| queues | Service Bus queues outputs. |
| subscriptions | Service Bus topics subscriptions outputs. |
| topics | Service Bus topics outputs. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/service-bus/](https://docs.microsoft.com/en-us/azure/service-bus/)
