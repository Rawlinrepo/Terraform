#VPC
resource "aws_vpc" "vpc" {
  tags = {
    Name = "app-vpc"
  }
  cidr_block = "25.25.0.0/16"
}

#Public Subnet
resource "aws_subnet" "public" {
  tags = {
    Name = "app-public-subnet"
  }
  vpc_id = aws_vpc.vpc.id
  cidr_block = "25.25.1.0/24"
}

#Private Subnet
resource "aws_subnet" "private" {
  tags = {
    Name = "app-private-subnet"
  }
  vpc_id = aws_vpc.vpc.id
  cidr_block = "25.25.2.0/24"
}

#Internet Gateway
resource "aws_internet_gateway" "ig" {
  tags = {
    Name = "app-ig"
  }
  vpc_id = aws_vpc.vpc.id
}

#Routing Table
resource "aws_route_table" "rt" {
  tags = {
    Name = "app-rt"
  }
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

#Route Table Association
resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.public.id
}