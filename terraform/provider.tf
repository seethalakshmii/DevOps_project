terraform {
  required_version = ">= 1.6"

  backend "s3" {
    bucket = "devops-tf-state-12345-xyz789"
    key    = "terraform/state.tfstate"
    region = "ap-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}