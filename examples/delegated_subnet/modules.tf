data "azurerm_subnet" "example" {
  name                 = "backend"
  virtual_network_name = "production"
  resource_group_name  = module.rg.name
}

module "servicebus" {
  source  = "claranet/service-bus/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

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
    default_message_ttl = "P1D" # 1 day

    dead_lettering_on_message_expiration = true

    authorizations = {
      listen = true
      send   = false
    }
  }]

  servicebus_topics = [{
    name                = "mytopic"
    default_message_ttl = 5 # 5min

    authorizations = {
      listen = true
      send   = true
      manage = false
    }

    subscriptions = [{
      name = "mainsub"

      max_delivery_count         = 10
      batched_operations_enabled = true
      lock_duration              = 1 # 1 min
    }]
  }]

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id
  ]

  extra_tags = {
    foo = "bar"
  }
}
