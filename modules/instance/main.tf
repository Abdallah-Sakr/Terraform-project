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
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "echo '<!DOCTYPE html><html><head><title>My Web Page</title></head><body><h1>Welcome to My Web Page</h1><p>This is a sample web page served by Apache.</p></body></html>' | sudo tee /var/www/html/index.html",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip }

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
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "echo '<!DOCTYPE html><html><head><title>My Web Page</title></head><body><h1>Welcome to My Web Page</h1><p>This is a sample web page served by Apache.</p></body></html>' | sudo tee /var/www/html/index.html",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]

connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
      timeout     = "10m"
    }
  }
}
