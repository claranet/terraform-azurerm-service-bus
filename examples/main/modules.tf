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

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
