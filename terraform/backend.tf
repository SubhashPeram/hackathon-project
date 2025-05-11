terraform {
  backend "s3" {
    bucket         = var.bucket_name
    key            = "fargate/terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-locks"
  }
}
