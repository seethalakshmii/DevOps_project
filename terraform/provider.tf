terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  # ADD THIS: Configures remote state storage in your Mumbai S3 bucket
  backend "s3" {
    bucket         = "devops-tf-state-12345-xyz789" # Your exact bucket name
    key            = "state/terraform.tfstate"       # The file path inside your bucket
    region         = "ap-south-1"                    # Mumbai region
    encrypt        = true                            # Encrypt state file at rest
  }
}

provider "aws" {
  region = var.aws_region
}