terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-wp-app"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.10.0/24", "10.0.20.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_efs_file_system" "wp-app-efs" {
  encrypted = true


  tags = {
    Name = "wp-app-efs"
  }
}

resource "aws_db_subnet_group" "wp-app-rds-subnet" {
  name       = "wp-app-rds-subnet"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "wp-app-rds-subnet"
  }
}

resource "aws_db_instance" "wp-app-rds" {
  identifier           = "wpapprds"
  instance_class       = "db.t3.micro"
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.35"
  username             = "admin"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.wp-app-rds-subnet.name
  publicly_accessible  = false
  skip_final_snapshot  = true
}
