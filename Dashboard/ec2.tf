resource "aws_instance" "ec2" {
  tags = {
    Name = "Dashboard-EC2"
  }
  ami                         = data.aws_ami.name.image_id
  instance_type               = "t4g.small"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key_pair.key_name
  depends_on                  = [aws_key_pair.key_pair,local_file.private_key]
  private_ip = "50.50.0.170"
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  } 
}
  