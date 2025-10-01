#Fetch latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu) account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}

#EC2 instance for Nginx
resource "aws_instance" "nginx" {
    tags = {
      Name = "app-nginx"
    }
    ami = data.aws_ami.ubuntu.id
    instance_type = "t4g.nano"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    associate_public_ip_address = true
    user_data = file("nginx.sh")
}