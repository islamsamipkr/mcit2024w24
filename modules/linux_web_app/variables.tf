variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }

variable "service_plan_name" { type = string }
variable "service_plan_tier" { type = string default = "Basic" }
variable "service_plan_size" { type = string default = "B1" }

variable "site_config" {
  type = object({
    always_on     = bool
    http2_enabled = bool
  })
  default = {
    always_on     = true
    http2_enabled = true
  }
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "identity_type" {
  type    = string
  default = "SystemAssigned"
}
