output "public-ip" {
  value = aws_instance.ec2.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.ec2.private_ip
}

output "ssh" {
  value = "ssh -i C:/Users/RYLAN/devops/Terraform/Dashboard/${aws_key_pair.key_pair.key_name}.pem ubuntu@${aws_instance.ec2.public_ip}"
}

output "Website_is_live_on" {
  value = "http://${aws_instance.ec2.public_ip}"
}
