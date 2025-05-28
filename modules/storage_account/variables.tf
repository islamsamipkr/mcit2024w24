variable "name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where the storage account will be created."
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type (LRS, GRS, etc.)."
  type        = string
  default     = "LRS"
}

variable "kind" {
  description = "The kind of storage account."
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Defines the access tier (Hot or Cool)."
  type        = string
  default     = "Hot"
}

variable "tags" {
  description = "Optional tags for the storage account."
  type        = map(string)
  default     = {}
}
