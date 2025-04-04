resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket-${random_id.suffix.hex}"
  lifecycle {
    prevent_destroy = false
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}


resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "crypt" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_dynamodb_table" "state_locks" {
  name = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
}