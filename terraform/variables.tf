variable "region" {
  default = "us-east-1"
}

variable "account_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}

variable "bucket_name" {
  default = "hackathon-tf-state"
}

variable "dynamodb_table_name" {
  default = "terraform-locks"
}