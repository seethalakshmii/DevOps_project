variable "aws_region" {
  type        = string
  default     = "ap-south-1" # Mumbai
  description = "The target AWS Region for all resources"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro" # t3.micro size
  description = "The size of the target EC2 application host"
}

variable "ami_id" {
  type        = string
  default     = "ami-03f4878755434977f" # Ubuntu 22.04 LTS HVM AMI specific to ap-south-1
  description = "The Operating System Base Image ID"
}

variable "key_name" {
  type        = string
  default     = "devops-project-key"
  description = "The descriptive name assigned to the dynamically generated SSH Key Pair"
}