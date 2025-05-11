provider "aws" { region = var.region }
resource "aws_ecs_cluster" "main" { name = "hackathon-cluster" }

module "services" {
  source = "./services-module"
  services = [
    { name = "patient-service", image = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/patient-service:latest" },
    { name = "appointment-service", image = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/appointment-service:latest" }
  ]
}
