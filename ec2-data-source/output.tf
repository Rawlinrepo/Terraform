#VPC ID
output "VPC-ID" {
  value = data.aws_vpc.vpc.id
}
#Private Subnet ID
output "Private-subnet-id" {
  value = data.aws_subnet.private.id
}
#Public Subnet ID
output "Public-subnet-id" {
  value = data.aws_subnet.public.id
}

#URL
output "URL" {
  value = "http://${aws_instance.ec2.public_ip}"
}