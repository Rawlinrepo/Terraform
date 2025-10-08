resource "aws_vpc" "vpc" {
  tags = {
    Name = "Dashboard-VPC"
  }
  cidr_block = "50.50.0.0/16"
}

resource "aws_internet_gateway" "ig" {
  tags = {
    Name = "Dashboard-IG"
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Dashboard-Public-Subnet"
  }
  cidr_block = "50.50.0.0/24"
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}