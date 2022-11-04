# Storage Firewall

variable "network_rules_enabled" {
  description = "Boolean to enable Network Rules on the Service Bus Namespace, requires `trusted_services_allowed`, `allowed_cidrs`, `subnet_ids` or `default_firewall_action` correctly set if enabled."
  type        = bool
  default     = true
}

variable "trusted_services_allowed" {
  description = "If True, then Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration."
  type        = bool
  default     = true
}

variable "allowed_cidrs" {
  description = "List of CIDR to allow access to that Service Bus Namespace."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnets to allow access to that Service Bus Namespace."
  type        = list(string)
  default     = []
}

variable "default_firewall_action" {
  description = "Which default firewalling policy to apply. Valid values are `Allow` or `Deny`."
  type        = string
  default     = "Deny"
}
