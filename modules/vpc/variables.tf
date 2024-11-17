variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+$", var.vpc_cidr_block))
    error_message = "Must be a valid CIDR block"
  }
}

variable "vpc_subnet_public" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  validation {
    condition = alltrue([for cidr in var.vpc_subnet_public : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}\\/([1-9]|1[0-9]|2[0-9]|3[0-2])$", cidr))])
    error_message = "Each CIDR in the list must be a valid IPv4 CIDR block."
  }
}

variable "vpc_subnet_private" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  validation {
    condition = alltrue([for cidr in var.vpc_subnet_private : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}\\/([1-9]|1[0-9]|2[0-9]|3[0-2])$", cidr))])
    error_message = "Each CIDR in the list must be a valid IPv4 CIDR block."
  }
}

variable "env" {
  description = "Environment name (e.g., dev or prod)"
  type        = string
}

variable "vpc_availability_zones" {
  description = "List of availability zones to distribute subnets across"
  type        = list(string)
  validation {
    condition     = length(var.vpc_availability_zones) > 0
    error_message = "You must provide at least one availability zone."
  }
}