terraform {
  backend "s3" {
    bucket = "devops-tf-state-12345-xyz789"
    key    = "terraform/state"
    region = "ap-south-1"
  }
}
provider "aws" {
  region = "ap-south-1"
}