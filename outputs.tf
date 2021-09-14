output "target_group_arns" {
  value = module.alb.target_group_arns
}

output "alb_dns" {
  value = module.alb.lb_dns_name
}