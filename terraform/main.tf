provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "main" {
  name = "hackathon-cluster"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Effect = "Allow",
      Sid = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/hackathon"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "patient" {
  family                   = "patient-service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([{
    name  = "patient",
    image = "<ECR_URI>/patient-service:latest",
    essential = true,
    portMappings = [{ containerPort = 3000, hostPort = 3000 }],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.ecs_log_group.name,
        awslogs-region        = "us-east-1",
        awslogs-stream-prefix = "patient"
      }
    }
  }])
}

resource "aws_ecs_task_definition" "appointment" {
  family                   = "appointment-service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([{
    name  = "appointment",
    image = "<ECR_URI>/appointment-service:latest",
    essential = true,
    portMappings = [{ containerPort = 3000, hostPort = 3000 }],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.ecs_log_group.name,
        awslogs-region        = "us-east-1",
        awslogs-stream-prefix = "appointment"
      }
    }
  }])
}
