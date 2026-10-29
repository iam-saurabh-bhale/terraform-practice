variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "Provide at least two public subnet IDs for the ALB."
  }
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EC2 instances"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 1
    error_message = "Provide at least one private subnet ID."
  }
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}