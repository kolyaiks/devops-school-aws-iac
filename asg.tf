resource "aws_launch_configuration" "wordpress_server_launch_configuration" {
  name_prefix = "wordpress_server_lc-"
  image_id = data.aws_ami.latest_amazon_linux_2.id
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.wordpress_server_instance_profile.name
  key_name = var.ssh_key_name
  security_groups = [
    aws_security_group.alb_via_http_to_ec2_sg.id,
    aws_security_group.internet_via_ssh_to_ec2_sg.id,
    aws_security_group.ec2_to_rds_sg.id,
    aws_security_group.ec2_to_efs_sg.id
  ]

  user_data = templatefile("userData.tpl", {
    db_name = var.db_name
    db_user = var.db_user,
    db_password = var.db_password,
    db_host = module.db.db_instance_address,
    company_name = var.company_name
    alb_dns = module.alb.lb_dns_name
    wp_admin = var.wp_admin
    wp_password = var.wp_password
    wp_admin_email = var.wp_admin_email
    efs_dns_name = aws_efs_file_system.efs.dns_name
  })

  root_block_device {
    volume_type = "standard"
    volume_size = 8
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wordpress_server_asg" {
  name_prefix = "wordpress_server_asg-${aws_launch_configuration.wordpress_server_launch_configuration.name}-"

  launch_configuration = aws_launch_configuration.wordpress_server_launch_configuration.name
  vpc_zone_identifier = module.vpc.public_subnets
  target_group_arns = module.alb.target_group_arns

  max_size = var.wordpress_server_max_size
  min_size = var.wordpress_server_min_size
  desired_capacity = var.wordpress_server_desired_capacity

  health_check_type = "ELB"
  health_check_grace_period = 120

  tag {
    key = "Name"
    value = "wordpress_server"
    propagate_at_launch = true
  }

  tag {
    key = "owner"
    value = var.owner_email
    propagate_at_launch = true
  }

  tag {
    key = "env"
    value = var.env
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}