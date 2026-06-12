variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "app_name" {
  description = "EC2 Name tag"
  type        = string
  default     = "DevOps-App-Server"
}