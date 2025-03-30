variable "alb_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

locals {
  http_port = 80
}
