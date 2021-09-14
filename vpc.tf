module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.company_name}-${var.env}-vpc"
  cidr = var.vpc_cidr

  azs = var.azs
  public_subnets = var.vpc_public_subnets_cidrs
  private_subnets = var.vpc_private_subnets_cidrs

  enable_dns_hostnames = true

  tags = {
    owner = var.owner_email
    env = var.env
  }
}