#EC2 Using Datasource
resource "aws_instance" "ec2" {
 tags = {
   Name = "ec2-data-source"
 }
 ami = data.aws_ami.ami.id
 instance_type = "t4g.nano"
 vpc_security_group_ids = [data.aws_security_group.sg.id]
 subnet_id = data.aws_subnet.private.id
 associate_public_ip_address = true 
}