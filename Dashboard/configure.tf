resource "null_resource" "configure_scripts" {
  triggers = {
      configure_hash = data.archive_file.configure_zip.output_base64sha256
  }

  provisioner "file" {
    source      = "configure.zip"
    destination = "/home/ubuntu/configure.zip"

    connection {
      type        = "ssh"
      host        = aws_instance.ec2.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_4096.private_key_pem
    }
  }

  provisioner "remote-exec" {
    inline = [
      "unzip -o /home/ubuntu/configure.zip -d /home/ubuntu/configure",
      "chmod +x /home/ubuntu/configure/*.sh",
      "for s in /home/ubuntu/configure/*.sh; do bash $s; done"
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.ec2.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_4096.private_key_pem
    }
  }

  depends_on = [null_resource.install_scripts]
}
