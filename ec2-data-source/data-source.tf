#Data source to find VPS
data "aws_vpc" "vpc" {
  tags = {
    Name = "app-vpc" 
  }
}

#Data source to find Private Subnet ID
data "aws_subnet" "private" {
  tags = {
    Name = "app-private-subnet"
  }
}

#Data source to find Public Subnet ID
data "aws_subnet" "public" {
  tags = {
    Name = "app-public-subnet"
  }
}

#Data source to find Security Group
data "aws_security_group" "sg" {
  tags = {
    Name = "nginx-sg"
  }
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}