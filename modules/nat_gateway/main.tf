# إنشاء Elastic IP لـ NAT Gateway
resource "aws_eip" "nat_eip" {
   domain = "vpc"

  tags = {
    Name = "${var.name}-nat-eip"
  }
}

# إنشاء NAT Gateway داخل Public Subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(var.public_subnet_ids, 0) # Public Subnet to place NAT
  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

# إنشاء Route Table للشبكات الخاصة
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-private-route-table"
  }
}

# إضافة مسار NAT Gateway إلى Route Table الخاصة
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"  # All outbound traffic
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# ربط Private Subnets بـ Route Table
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_ids)
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = aws_route_table.private_rt.id
}
