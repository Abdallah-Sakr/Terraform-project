
resource "aws_instance" "web_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = element(var.subnet_ids, 0)
  security_groups = [var.security_group_id]

  tags = {
    Name = var.name
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y >> /tmp/provisioner.log 2>&1",

      "sudo apt install httpd -y >> /tmp/provisioner.log 2>&1",

      "echo '<!DOCTYPE html><html><head><title>My Web Page</title></head><body><h1>Welcome to My Web Page</h1><p>This is a sample web page served by Apache.</p></body></html>' > /var/www/html/index.html >> /tmp/provisioner.log 2>&1",

      "sudo systemctl start httpd >> /tmp/provisioner.log 2>&1",

      "sudo systemctl enable httpd >> /tmp/provisioner.log 2>&1",

    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "5m"
    }
  }
}


resource "aws_instance" "web_server2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = element(var.subnet_ids, 1)
  security_groups = [var.security_group_id]

  tags = {
    Name = var.name
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y >> /tmp/provisioner.log 2>&1",

      "sudo apt install httpd -y >> /tmp/provisioner.log 2>&1",

      "echo '<!DOCTYPE html><html><head><title>My Web Page</title></head><body><h1>Welcome to My Web Page</h1><p>This is a sample web page served by Apache.</p></body></html>' > /var/www/html/index.html >> /tmp/provisioner.log 2>&1",

      "sudo systemctl start httpd >> /tmp/provisioner.log 2>&1",

      "sudo systemctl enable httpd >> /tmp/provisioner.log 2>&1",

    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "5m"
    }
  }
}
