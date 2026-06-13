# 1. Dynamically generate an asymmetric private key pair
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Register public credentials directly into the EC2 engine
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# 3. Store private key securely in AWS Systems Manager Parameter Store
resource "aws_ssm_parameter" "ec2_private_key" {
  name        = "/devops/ec2_private_key"
  type        = "SecureString"
  value       = tls_private_key.ec2_key.private_key_pem
  description = "Dynamically generated SSH private key for EC2 deployment"
  overwrite   = true
}

# 4. Create the ECR repository matching the repo name requirements
resource "aws_ecr_repository" "app_repo" {
  name                 = "devops-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

# 5. Security Group Configurations
resource "aws_security_group" "app_sg" {
  name        = "devops-project-sg"
  description = "Allow inbound SSH and App traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 6. EC2 Host Instance Assignment
resource "aws_instance" "web_app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name 
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io awscli
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "DevOps-Project-Target"
  }
}

# 7. Public IP Export Definition Block
output "ec2_public_ip" {
  value       = aws_instance.web_app.public_ip
  description = "The dynamically provisioned public IP of the EC2 Instance."
}