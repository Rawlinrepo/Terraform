terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "6.14.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

#VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "My-VPC"
  }
}

#Public  Subnet
resource "aws_subnet" "public" {
    cidr_block = "10.10.2.0/24"
    vpc_id = aws_vpc.vpc.id 
    tags = {
        Name = "public-subnet1"
    } 
}

#Private Subnet
resource "aws_subnet" "private" {
    cidr_block = "10.10.1.0/24"
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "private-subnet1"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "Internet-Gateway"
  }
  vpc_id = aws_vpc.vpc.id
}

#Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Route Table Association
resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.public.id
}

#EC2
resource "aws_instance" "ec2" {
  tags = {
    Name = "Rawlin-instance-vpc"
  }
  ami           = "ami-0b9093ea00a0fed92"
  instance_type = "t4g.nano"
  subnet_id = aws_subnet.public.id
}