data "aws_ami" "name" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}

data "archive_file" "install_zip" {
  type        = "zip"
  source_dir  = "./scripts/install" 
  output_path = "./install.zip"
}
data "archive_file" "configure_zip" {
  type        = "zip"
  source_dir  = "./scripts/configure" 
  output_path = "./configure.zip"
}

