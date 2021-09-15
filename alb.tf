module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "${var.company_name}-${var.env}-alb"
  enable_cross_zone_load_balancing = true
  load_balancer_type = "application"

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  security_groups = [
    aws_security_group.internet_via_http_to_alb_sg.id,
    aws_security_group.alb_via_http_to_ec2_sg.id]

  target_groups = [
    {
      name_prefix = "wp-tg-"
      backend_protocol = "HTTP"
      backend_port = 80
      target_type = "instance"
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }
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