# معرف VPC
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# معرفات Public Subnets
variable "public_subnet_ids" {
  description = "List of IDs of public subnets"
  type        = list(string)
}

# معرفات Private Subnets
variable "private_subnet_ids" {
  description = "List of IDs of private subnets"
  type        = list(string)
}

# اسم الموارد
variable "name" {
  description = "Name prefix for resources"
  type        = string
}
