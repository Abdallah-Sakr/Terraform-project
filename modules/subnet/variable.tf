variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "name" {
  description = "The name prefix for the subnets"
  type        = string
}
