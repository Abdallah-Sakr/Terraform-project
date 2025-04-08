# Security Group for Public Subnets
resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  name        = "${var.name}-public-sg"
  description = "Security group for public-facing resources"

  tags = {
    Name = "${var.name}-public-sg"
  }
}

# Rule: Allow HTTP (Port 80)
resource "aws_security_group_rule" "public_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # السماح لجميع الاتصالات الواردة
  security_group_id = aws_security_group.public_sg.id
}

# Rule: Allow HTTPS (Port 443)
resource "aws_security_group_rule" "public_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

# Rule: Allow SSH (Port 22) - Restricted to your IP address
resource "aws_security_group_rule" "public_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # استبدل بعنوان IP الخاص بك
  security_group_id = aws_security_group.public_sg.id
}

# Rule: Allow all outbound traffic for Public SG
resource "aws_security_group_rule" "public_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

# Security Group for Private Subnets
resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  name        = "${var.name}-private-sg"
  description = "Security group for private resources"

  tags = {
    Name = "${var.name}-private-sg"
  }
}

# Rule: Allow MySQL (Port 3306) connections from Public Subnets
resource "aws_security_group_rule" "private_mysql" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = var.public_subnet_cidrs  # السماح فقط باتصالات من الشبكات العامة
  security_group_id = aws_security_group.private_sg.id
}

# Rule: Allow all outbound traffic for Private SG
resource "aws_security_group_rule" "private_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_sg.id
}
