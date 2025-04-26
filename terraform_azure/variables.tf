# variables.tf

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "webapp-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westus" # Changed from eastus to try a different region
}

variable "webapp_name" {
  description = "Name of the Web App (will be appended with random string)"
  type        = string
  default     = "mywebapp"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry (will be appended with random string)"
  type        = string
  default     = "acr"
}
