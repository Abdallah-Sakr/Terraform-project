resource "aws_instance" "web_server1" {
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
      "sudo systemctl start httpd >> /tmp/provisioner.log 2>&1",

      "sudo systemctl enable httpd >> /tmp/provisioner.log 2>&1",

    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.private_ip
       timeout     = "5m"
    }
  }
}

resource "aws_instance" "web_server3" {
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
      "sudo apt update -y",
      "sudo apt install httpd -y >> /tmp/provisioner.log 2>&1",
      "sudo systemctl start httpd >> /tmp/provisioner.log 2>&1",

      "sudo systemctl enable httpd >> /tmp/provisioner.log 2>&1",
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.private_ip
       timeout     = "5m"
    }
  }
}
