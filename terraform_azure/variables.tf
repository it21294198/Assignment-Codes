# variables.tf
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "webapp_name" {
  description = "Name of the Azure Web App"
  type        = string
}

variable "docker_image" {
  description = "Docker image name (e.g., username/image:tag)"
  type        = string
}
