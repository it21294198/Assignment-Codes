variable "aws_region" {
  default = "us-east-1"
}

variable "ecr_repo_name" {
  default = "webapp1"
}

variable "ecs_cluster_name" {
  default = "webapp1-cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ECS service networking"
}

variable "security_group_id" {
  type        = string
  description = "Security group for the ECS service"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "IAM role ARN for ECS task execution"
}
