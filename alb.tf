module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "${var.company_name}-${var.env}-alb"

  load_balancer_type = "application"

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  security_groups = [
    aws_security_group.http_sg.id]

  target_groups = [
    {
      name_prefix = "wp-tg-"
      backend_protocol = "HTTP"
      backend_port = 80
      target_type = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port = 80
      protocol = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    owner = var.owner_email
    env = var.env
  }
}