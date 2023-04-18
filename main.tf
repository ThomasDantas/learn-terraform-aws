provider "aws" {
  region  = var.region
  profile = "default"
}
module "postgresql" {
  source = "./postgresql"

  db_password = var.db_password
  environment = var.environment
  region      = var.region
}
