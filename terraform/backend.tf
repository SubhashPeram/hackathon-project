terraform {
  backend "s3" {
    bucket         = "my-tf-statet"
    key            = "fargate/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
  }
}
