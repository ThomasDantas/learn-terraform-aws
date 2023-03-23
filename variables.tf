variable "environment" {
  type    = string
  default = "beta"
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}