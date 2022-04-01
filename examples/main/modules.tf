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

module "servicebus" {
  source  = "claranet/service-bus/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  servicebus_namespaces_queues = {
    # You can just create a servicebus_namespace
    servicebus0 = {}

    # Or create a servicebus_namespace with some queues with default values
    servicebus1 = {
      queues = {
        queue1 = {}
        queue2 = {}
      }
    }

    # Or customize everything
    servicebus2 = {
      custom_name = format("%s-%s-%s-custom", var.stack, var.client_name, module.azure_region.location_short)
      sku         = "Premium"
      capacity    = 2

      queues = {
        queue100 = {
          reader = true
          sender = true
          manage = true
        }
        queue200 = {
          dead_lettering_on_message_expiration = true
          default_message_ttl                  = "PT10M"
          reader                               = true
        }
        queue300 = {
          duplicate_detection_history_time_window = "PT30M"
          sender                                  = true
        }
        queue400 = {
          requires_duplicate_detection = true
          manage                       = true
        }
      }
    }
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
