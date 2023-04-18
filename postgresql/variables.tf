variable "environment" {
  type = string
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS region"
}
