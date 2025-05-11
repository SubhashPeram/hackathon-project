terraform {
  backend "s3" {
    bucket         = "hackathon-terraform-state"
    key            = "fargate/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
  }
}
