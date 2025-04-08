variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_security_group_id" {
  description = "Security group ID for public ALB"
  type        = string
}

variable "private_security_group_id" {
  description = "Security group ID for private ALB"
  type        = string
}

variable "name" {
  description = "Shortened name prefix for resources"
  type        = string
  default     = "my-alb"
}
