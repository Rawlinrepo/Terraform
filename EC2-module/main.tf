module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"
 

  tags = {
    Name = "myec2"
  }
}