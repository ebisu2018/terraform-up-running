variable "dynamodb_table" {
  type = string
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  default = "terraform-state-bucket-locks"
}