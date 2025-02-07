variable "subscription_id"{
  type=string
}

variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "tenant_id"{
  type=string
}

variable "my_mcit_variable" {
  description = "A simple variable"
  type        = string
  default     = "Hello, World!"
}
output "my_variable_output2" {
  value = var.my_mcit_variable
}
