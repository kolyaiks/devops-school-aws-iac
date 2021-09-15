resource "aws_efs_file_system" "efs" {
  encrypted = "true"
  tags = {
    owner = var.owner_email
    env = var.env
  }
}

resource "aws_efs_mount_target" "mount_target" {
  # Can't use for_each here because there is no value of subnet id
  # which must be used as index of new resource on the first launch of Terraform script:
  # https://discuss.hashicorp.com/t/the-for-each-value-depends-on-resource-attributes-that-cannot-be-determined-until-apply/25016/2
  count = length(module.vpc.public_subnets)

  file_system_id = aws_efs_file_system.efs.id
  subnet_id = module.vpc.public_subnets[count.index]

  security_groups = [
    aws_security_group.ec2_to_efs_sg.id]
}