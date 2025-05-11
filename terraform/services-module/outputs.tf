output "service_names" {
  value = [for svc in aws_ecs_service.this : svc.name]
}
