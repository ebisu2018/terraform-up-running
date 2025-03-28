variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "cluster_name" {
  type = string
}

# variable "db_remote_state_bucket" {
#   type = string
# }
#
# variable "db_remote_state_key" {
#   type = string
# }

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired" {
  type = number
}

variable "user_data_script" {
  type = string
}

variable "enable_autoscaling" {
  type = bool
}

variable "target_group_arns" {
  type = list(string)
  default = []
}

variable "subnet_ids" {
  type = list(string)
}

variable "any_port" {
  type = number
}

variable "any_protocol" {
  type = string
}

variable "all_ips" {
  type = list(string)
}
