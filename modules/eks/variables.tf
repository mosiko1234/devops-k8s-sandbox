variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  validation {
    condition     = length(var.cluster_name) > 0 && length(var.cluster_name) <= 50
    error_message = "cluster_name must not be empty and should be less than or equal to 50 characters."
  }
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  validation {
    condition     = can(regex("^1\\.(\\d+)$", var.cluster_version))
    error_message = "cluster_version must be in the format 1.x (e.g., 1.21, 1.22)."
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "subnet_ids cannot be empty. Please provide at least one subnet ID."
  }
}

variable "instance_type" {
  description = "The type of EC2 instances for the worker nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  validation {
    condition     = var.desired_capacity >= 0
    error_message = "Desired capacity must be greater than or equal to 0."
  }
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  validation {
    condition     = var.max_capacity > 0
    error_message = "max_capacity must be greater than 0."
  }
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  validation {
    condition     = var.min_capacity >= 1
    error_message = "min_capacity must be at least 1."
  }
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  validation {
    condition     = length(keys(var.tags)) > 0
    error_message = "tags cannot be empty. Please provide at least one tag."
  }
}
