#Public Ip url
output "instance-url" {
  value = "http://${aws_instance.nginx.public_ip}"
}