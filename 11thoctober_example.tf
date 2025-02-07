variable "octobereleven"{
    type=string
    default="11"
}
variable "octobertwelve"{
    type=string
    default="12"
} 
output "octobertogether"{
   value="${var.octobereleven}+${var.octobertwelve}"
}
###################################################3
variable "octoberelevensecondexample1"{
    type=number
    default=11
}
variable "octoberelevensecondexample2"{
    type=number
    default=12
}
output "sumofoctoberdates"{
  value="${var.octoberelevensecondexample1}+${var.octoberelevensecondexample2}"
}
output "sumofoctoberdatesreal"{
  value=var.octoberelevensecondexample1+var.octoberelevensecondexample2
}
###########################################################
variable "mcit_list"{
    type =list(string)
    default=["one","two","three"]
}

output "mcit_list_output"{
    value=var.mcit_list
}

########################################################
output "mcit_tranformed_list"{
    value=[for item in var.mcit_list:"${item}_transformed"]
}

variable "my_variable" {
  description = "A simple variable"
  type        = string
  default     = "Hello, World!"
}
output "my_variable_output" {
  value = var.my_variable
}
