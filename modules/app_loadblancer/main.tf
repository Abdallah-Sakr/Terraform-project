# Public Application Load Balancer
resource "aws_lb" "public_alb" {
  name               = "${var.name}-pub-alb"       # Shortened even further
  internal           = false
  security_groups    = [var.public_security_group_id]
  subnets            = var.public_subnet_ids
  load_balancer_type = "application"

  tags = {
    Name = "${var.name}-pub-alb"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.http_tg.arn
  }
}

resource "aws_lb_target_group" "http_tg" {
  name        = "${var.name}-pub-tg"              # Shorter name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.name}-pub-tg"
  }
}

# Private Application Load Balancer
resource "aws_lb" "private_alb" {
  name               = "${var.name}-pri-alb"       # Shortened even further
  internal           = true
  security_groups    = [var.private_security_group_id]
  subnets            = var.private_subnet_ids
  load_balancer_type = "application"

  tags = {
    Name = "${var.name}-pri-alb"
  }
}

resource "aws_lb_listener" "private_http_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.private_http_tg.arn
  }
}

resource "aws_lb_target_group" "private_http_tg" {
  name        = "${var.name}-pri-tg"              # Shortened name
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/healthcheck"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.name}-pri-tg"
  }
}
