resource "aws_security_group" "internet_via_http_to_alb_sg" {
  name = "internet_via_http_to_alb_sg"
  description = "Allow HTTP inbound from Internet to ALB"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP inbound from Internet to ALB"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    owner = var.owner_email
    env = var.env
  }
}

resource "aws_security_group" "alb_via_http_to_ec2_sg" {
  name = "alb_via_http_to_ec2_sg"
  description = "HTTP traffic between ALB and EC2"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "HTTP traffic between ALB and EC2"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    owner = var.owner_email
    env = var.env
  }
}

resource "aws_security_group" "internet_via_ssh_to_ec2_sg" {
  name = "internet_via_ssh_to_ec2_sg"
  description = "Allow SSH inbound"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow SSH inbound"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.ssh_inbound_list_allowed
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    owner = var.owner_email
    env = var.env
  }
}

resource "aws_security_group" "ec2_to_rds_sg" {
  name = "ec2_to_rds_sg"
  description = "EC2 with access to RDS MySQL"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow access to RDS MySQL"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    owner = var.owner_email
    env = var.env
  }
}

resource "aws_security_group" "ec2_to_efs_sg" {
  name = "ec2_to_efs_sg"
  description = "EC2 with access to EFS disk"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow access to EFS disk"
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    owner = var.owner_email
    env = var.env
  }
}

