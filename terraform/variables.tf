variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "app_name" {
  description = "Application name used for tagging"
  type        = string
  default     = "DevOps-App-Server"
}

