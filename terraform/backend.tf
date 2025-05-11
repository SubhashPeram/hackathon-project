terraform {
  backend "s3" {
    bucket         = "hackathon-terraform-state"
    key            = "fargate/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }
}
