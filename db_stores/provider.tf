provider "aws" {
  region = "ap-northeast-1"
  profile = "zayed"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.92.0"
    }
  }

#   backend "s3" {
#     key = "stage/data-stores/mysql/terraform.tfstate"
#   }
}