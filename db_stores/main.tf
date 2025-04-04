resource "aws_db_instance" "rds-mysql" {
  engine = "mysql"
  instance_class = var.db_instance-class
  allocated_storage = 10
  db_name = var.db_name
  username = var.username
  password = data.aws_secretsmanager_secret_version.mysql_pwd.secret_string
}

data "aws_secretsmanager_secret_version" "mysql_pwd" {
  secret_id = "mysql-password-stage"
}