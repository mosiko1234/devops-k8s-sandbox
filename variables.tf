variable "region" {
  description = "The AWS region"
  type        = string
}

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
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}

variable "availability_zones" {
  description = "List of availability zones to distribute subnets across"
  type        = list(string)
}

variable "enable_eks" {
  description = "Enable EKS module"
  type        = bool
  default     = false
}

variable "enable_vpc" {
  description = "Enable VPC module"
  type        = bool
  default     = true
}

