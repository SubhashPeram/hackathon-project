provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

resource "aws_ecs_cluster" "main" {
  name = "hackathon-cluster"
}

module "services" {
  source = "./services-module"
  services = [
    { name = "patient-service", image = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/patient-service:latest" },
    { name = "appointment-service", image = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/appointment-service:latest" }
  ]

  cluster_id         = aws_ecs_cluster.main.id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
}
