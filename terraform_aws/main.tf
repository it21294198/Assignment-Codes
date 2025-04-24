provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "webapp_repo" {
  name = var.ecr_repo_name
}

resource "aws_ecs_cluster" "webapp_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "webapp_task" {
  family                   = "webapp-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_task_execution_role_arn
  container_definitions = jsonencode([
    {
      name      = "webapp1"
      image     = "${aws_ecr_repository.webapp_repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "webapp_service" {
  name            = "webapp-service"
  cluster         = aws_ecs_cluster.webapp_cluster.id
  task_definition = aws_ecs_task_definition.webapp_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = [var.security_group_id]
  }

  depends_on = [aws_ecs_task_definition.webapp_task]
}
