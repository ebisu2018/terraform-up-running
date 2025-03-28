variable "alb_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

# variable "db_remote_state_bucket" {
#   type = string
# }
#
# variable "db_remote_state_key" {
#   type = string
# }

locals {
  http_port = 80
  any_port = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips = ["0.0.0.0/0"]
}
