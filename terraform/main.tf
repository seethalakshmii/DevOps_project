resource "aws_instance" "devops" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "devops-server"
  }
}

output "public_ip" {
  value = aws_instance.devops.public_ip
}