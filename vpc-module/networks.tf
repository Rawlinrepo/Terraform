module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.4.0"

  tags = {
    Name = "my-vpc-module"
  }
  name = "my-vpc-module"
  cidr = "30.30.0.0/16"
  azs = ["aps1-az1"]
  private_subnets = ["30.30.1.0/24","30.30.2.0/24","30.30.3.0/24"]
  public_subnets = ["30.30.4.0/24","30.30.5.0/24","30.30.6.0/24"]

  }

  provider "aws" {
    region = "ap-south-1"
  }