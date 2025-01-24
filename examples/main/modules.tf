module "servicebus" {
  source  = "claranet/service-bus/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  logs_destinations_ids = [module.logs.id]
}
