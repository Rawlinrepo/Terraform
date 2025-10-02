terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.14.1"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "name" {
  ami = "ami-0f5d42f0ba3ba0328"
  instance_type = "t4g.nano"
  count = 14
  tags = {
    Name = "App-server-${count.index+1}"
  }
}
