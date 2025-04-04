variable "db_instance-class" {
  type = string
  default = "db.t2.micro"
}

variable "db_name" {
  type = string
  default = "rds-mysql"
}

variable "username" {
  type = string
  default = "admin"
}