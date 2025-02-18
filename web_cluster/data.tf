data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# data "terraform_remote_state" "db" {
#   backend = "s3"
#   config = {
#     region = "ap-northeast-1"
#     bucket = var.db_remote_state_bucket
#     key = var.db_remote_state_key
#   }
# }

data "template_file" "user-data" {
  template = file(var.user_data_script)
  vars = {}
}
