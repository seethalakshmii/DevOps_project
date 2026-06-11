resource "aws_instance" "devops" {

  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"

  tags = {
    Name = "devops-server"
  }
}

output "public_ip" {
  value = aws_instance.devops.public_ip
}