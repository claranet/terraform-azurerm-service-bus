variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location for Servicebus."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

# Identity
variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Service Bus. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Service Bus."
  type        = list(string)
  default     = null
}

variable "servicebus_namespace" {
  description = <<EOD
Object to handle Service Bus Namespace options.
```
custom_name         = To override default resource name, generated if not set.
sku                 = Defines which tier to use. Options are `Basic`, `Standard` or `Premium`.
capacity            = Specifies the capacity. When SKU is `Premium`, capacity can be 1, 2, 4, 8 or 16.
local_auth_enabled  = Whether or not SAS authentication is enabled for the Service Bus namespace.
zone_redundant      = Whether or not this resource is zone redundant. SKU needs to be `Premium`.
minimum_tls_version = The minimum supported TLS version for this Service Bus Namespace.
public_network_access_enabled = Is public network access enabled for the Service Bus Namespace?
```
EOD
  type = object({
    custom_name         = optional(string)
    sku                 = optional(string, "Standard")
    capacity            = optional(number, 0)
    local_auth_enabled  = optional(bool, true)
    zone_redundant      = optional(bool, false)
    minimum_tls_version = optional(string, "1.2")

    public_network_access_enabled = optional(bool, true)
  })
}
