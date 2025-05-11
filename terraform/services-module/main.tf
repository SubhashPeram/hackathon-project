resource "aws_ecs_task_definition" "this" {
  for_each = { for svc in var.services : svc.name => svc }

  family                   = each.value.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = each.value.name
      image     = each.value.image
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "this" {
  for_each = aws_ecs_task_definition.this

  name            = each.key
  cluster         = var.cluster_id
  task_definition = each.value.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = var.security_group_ids
  }

  depends_on = [each.value]
}
