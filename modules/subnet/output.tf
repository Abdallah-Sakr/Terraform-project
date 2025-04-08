output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

# Output for Public Subnet CIDR Blocks
output "public_subnet_cidrs" {
  value = aws_subnet.public[*].cidr_block
}

# Output for Private Subnet CIDR Blocks
output "private_subnet_cidrs" {
  value = aws_subnet.private[*].cidr_block
}

