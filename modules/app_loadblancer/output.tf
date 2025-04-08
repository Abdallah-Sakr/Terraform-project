output "public_alb_dns_name" {
  value = aws_lb.public_alb.dns_name
}

output "private_alb_dns_name" {
  value = aws_lb.private_alb.dns_name
}

output "http_target_group_arn" {
  value = aws_lb_target_group.http_tg.arn
}

output "private_http_target_group_arn" {
  value = aws_lb_target_group.private_http_tg.arn
}
