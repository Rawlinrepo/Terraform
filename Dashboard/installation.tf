resource "null_resource" "install_scripts" {
  triggers = {
     install_hash   = data.archive_file.install_zip.output_base64sha256
  }

  provisioner "file" {
    source      = "install.zip"
    destination = "/home/ubuntu/install.zip"

    connection {
      type        = "ssh"
      host        = aws_instance.ec2.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_4096.private_key_pem
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y unzip",
      "unzip -o /home/ubuntu/install.zip -d /home/ubuntu/install",
      "chmod +x /home/ubuntu/install/*.sh",
      "for s in /home/ubuntu/install/*.sh; do sudo bash $s; done",
      "cd install",
      "bash 02-node-pnpm.sh",
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.ec2.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_4096.private_key_pem
    }
  }
}