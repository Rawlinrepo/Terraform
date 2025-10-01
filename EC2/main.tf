terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  tags = {
    Name = "Rawlin-instance"
  }
  ami           = "ami-0b9093ea00a0fed92"
  instance_type = "t4g.micro"
}