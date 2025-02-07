variable "my_variable" {
  description = "A simple variable"
  type        = string
  default     = "Hello, World!"
}
output "my_variable_output" {
  value = var.my_variable
}
