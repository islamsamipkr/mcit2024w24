variable "name" {
  description = "The name of the Linux Web App."
  type        = string
}

variable "location" {
  description = "The Azure region where the Web App will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "site_config" {
  description = "Site configuration for the Linux Web App."
  type = object({
    always_on                                     = optional(bool, true)
    ftps_state                                    = optional(string, "Disabled")
    http2_enabled                                 = optional(bool, true)
    websockets_enabled                            = optional(bool, false)
    use_32_bit_worker                             = optional(bool, false)
    container_registry_use_managed_identity       = optional(bool, false)
    container_registry_managed_identity_client_id = optional(string)
    worker_count                                  = optional(number)
  })
  default = {}
}

variable "app_settings" {
  description = "A map of application settings."
  type        = map(string)
  default     = {}
}

variable "identity_type" {
  description = "The type of managed identity to assign to the Web App."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of user-assigned identity IDs."
  type        = list(string)
  default     = []
}
