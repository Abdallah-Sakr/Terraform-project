# إخراج معرف NAT Gateway
output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

# إخراج معرف Route Table الخاصة
output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}
