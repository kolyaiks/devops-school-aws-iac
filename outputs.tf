output "alb_dns" {
  value = module.alb.lb_dns_name
}

output "target_group_arns" {
  value = module.alb.target_group_arns
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "efs_dns_name" {
  value = aws_efs_file_system.efs.dns_name
}