variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc" {
  description = "Name of the VPC"
  type        = string
  default     = "vpc"
}

