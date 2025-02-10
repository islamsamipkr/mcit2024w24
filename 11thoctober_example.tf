variable "my_variable" {
  description = "A simple variable"
  type        = string
  default     = "Hello, World!"
}
output "my_variable_output" {
  value = var.my_variable
}

variable "mcit_list"{
    type =list(string)
    default=["one","two","three"]
}
output "mcit_list_output"{
    value=var.mcit_list
}

