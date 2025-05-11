variable "region" {
  default = "us-west-2"
}

variable "account_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
