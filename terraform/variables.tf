variable "region" {
  default = "us-east-1"
}

variable "account_id" {
  default = "119537256357"  # Replace with your actual AWS account ID
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "bucket_name" {
  default = "subhash-tf-state"
}

variable "dynamodb_table_name" {
  default = "terraform-locks"
}