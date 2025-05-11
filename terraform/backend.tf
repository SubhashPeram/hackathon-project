terraform {
  backend "s3" {
    bucket         = "hackathon-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
