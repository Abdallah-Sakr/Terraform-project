resource "aws_instance" "web_server1" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(var.subnet_ids, 0)
  security_groups = [var.security_group_id]

  tags = {
    Name = var.name
  }

  # ﺎﺴﺘﺧﺩﺎﻣ user_data ﻞﺘﻨﻔﻳﺫ ﺃﻭﺎﻣﺭ ﻊﻧﺩ ﺏﺩﺀ ﺎﻠـ EC2 instance
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo '<!DOCTYPE html><html><head><title>My Web Page</title></head><body><h1>Welcome to My Web Page</h1><p>This is a sample web page served by Apache.</p></body></html>' | sudo tee /var/www/html/index.html
  EOF
}

resource "aws_instance" "web_server3" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(var.subnet_ids, 1)
  security_groups = [var.security_group_id]
tags = {
    Name = var.name
  }

  # ﺎﺴﺘﺧﺩﺎﻣ user_data ﻞﺘﻨﻔﻳﺫ ﺃﻭﺎﻣﺭ ﻊﻧﺩ ﺏﺩﺀ ﺎﻠـ EC2 instance
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo '<!DOCTYPE html><html><head><title>My Web Page</title></head><body><h1>Welcome to My Web Page</h1><p>This is a sample web page served by Apache.</p></body></html>' | sudo tee /var/www/html/index.html
  EOF
}

