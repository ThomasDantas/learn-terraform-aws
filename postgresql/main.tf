data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "vpc-${var.environment}"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}


resource "aws_db_subnet_group" "terraform-subnet" {
  name       = "subnet-${var.environment}"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "ExampleCreateSubnetGroup"
  }
}

resource "aws_security_group" "rds" {
  name   = "terraform_rds_${var.environment}"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example_create_sg"
  }
}

resource "aws_db_parameter_group" "terraform-parameter-group" {
  name   = "parameter-group-${var.environment}"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "terraformdb" {
  identifier             = "terraformdb"
  engine                 = "postgres"
  engine_version         = "14.1"
  db_name                = "mydb${var.environment}"
  username               = "foo"
  password               = var.db_password # export TF_VAR_db_password="mypassword"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  apply_immediately      = true
  backup_window          = "09:00-12:00"
  db_subnet_group_name   = aws_db_subnet_group.terraform-subnet.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.terraform-parameter-group.name
  publicly_accessible    = true
  skip_final_snapshot    = true

  tags = {
    Name = "ExampleCreateDatabaseInstance"
  }
}
