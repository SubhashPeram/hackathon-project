terraform {
  backend "s3" {
    bucket         = "hackathon-tf-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
