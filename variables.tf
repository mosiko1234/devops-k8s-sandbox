variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_subnet_public" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "vpc_subnet_private" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "env" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

variable "eks_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "eks_instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string
}

variable "eks_instance_scaling_desired" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "eks_instance_scaling_max" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "eks_instance_scaling_min" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}

variable "vpc_availability_zones" {
  description = "List of availability zones to distribute subnets across"
  type        = list(string)
}

variable "eks_enabled" {
  description = "Enable EKS module"
  type        = bool
  default     = false
}

variable "vpc_enabled" {
  description = "Enable VPC module"
  type        = bool
  default     = true
}

