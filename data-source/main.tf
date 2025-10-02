terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "6.14.1"
    }
  }
}
#Region
provider "aws" {
    region = "ap-south-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}

output "ami" {
  value = data.aws_ami.ubuntu
}


resource "aws_instance" "name" {
  ami = data.aws_ami.ubuntu.image_id
  instance_type = "t4g.nano"
}