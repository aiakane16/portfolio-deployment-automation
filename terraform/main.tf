terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
  access_key = var.AWS_KEY
  secret_key = var.AWS_SECRET
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

variable "AWS_KEY" {
  description = "AWS KEY "
  type        = string
  default     = null
}

variable "AWS_SECRET" {
  description = "AWS SECRET "
  type        = string
  default     = null
}

