variable "eks_name" {
  description = "The name of the EKS cluster"
  type        = string
  validation {
    condition     = length(var.eks_name) > 0 && length(var.eks_name) <= 50
    error_message = "cluster_name must not be empty and should be less than or equal to 50 characters."
  }
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
  validation {
    condition     = can(regex("^1\\.(\\d+)$", var.eks_version))
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

variable "eks_instance_type" {
  description = "The type of EC2 instances for the worker nodes"
  type        = string
}

variable "eks_instance_scaling_desired" {
  description = "Desired number of worker nodes"
  type        = number
  validation {
    condition     = var.eks_instance_scaling_desired >= 0
    error_message = "Desired capacity must be greater than or equal to 0."
  }
}

variable "eks_instance_scaling_max" {
  description = "Maximum number of worker nodes"
  type        = number
  validation {
    condition     = var.eks_instance_scaling_max > 0
    error_message = "max_capacity must be greater than 0."
  }
}

variable "eks_instance_scaling_min" {
  description = "Minimum number of worker nodes"
  type        = number
  validation {
    condition     = var.eks_instance_scaling_min >= 1
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
