variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
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

variable "env_name" {
  description = "Environment name (e.g., dev or prod)"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to distribute subnets across"
  type        = list(string)
}