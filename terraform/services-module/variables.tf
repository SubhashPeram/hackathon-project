variable "services" {
  description = "List of service definitions with name and image"
  type = list(object({
    name  = string
    image = string
  }))
}

variable "cluster_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
