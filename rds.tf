module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  publicly_accessible = var.db_publicly_accessible
  identifier = "wordpress-db-${var.company_name}"

  engine = "mysql"
  engine_version = "5.7.19"
  instance_class = var.db_instance_type
  allocated_storage = 5

  # To be able to delete infrastructure without additional snapshots
  skip_final_snapshot = var.db_skip_final_snapshot
  # Database will be created via wp cli in userData, not by Terraform
  name = null
  username = var.db_user
  password = var.db_password
  port = "3306"

  iam_database_authentication_enabled = false

  multi_az = var.db_multi_az

  vpc_security_group_ids = [
    aws_security_group.ec2_to_rds_sg.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window = "03:00-06:00"

  tags = {
    owner = var.owner_email
    env = var.env
  }

  # DB subnet group
  subnet_ids = module.vpc.public_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]
}