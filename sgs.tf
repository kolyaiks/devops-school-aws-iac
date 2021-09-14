resource "aws_security_group" "http_sg" {
  name = "http_sg"
  description = "Allow HTTP inbound"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP inbound"
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

resource "aws_security_group" "ssh_sg" {
  name = "ssh_sg"
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

resource "aws_security_group" "rds_sg" {
  name = "mysql_sg"
  description = "EC2 with access to RDS MySQL"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow access to RDS MySQL"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    self = true
  }

  //TODO: delete external access
  ingress {
    description = "Allow access to RDS MySQL"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      "94.26.145.223/32"]
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