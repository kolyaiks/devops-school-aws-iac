variable "region" {
  description = "Region to launch infra in"
  type = string
  default = "us-east-1"
}

variable "azs" {
  description = "List of AZs you need in this region"
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"]
}

variable "company_name" {
  description = "Company name"
  type = string
  default = "kolyaiks"
}

variable "env" {
  description = "Environment name"
  type = string
  default = "sandbox"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = "192.168.0.0/16"
}

variable "vpc_public_subnets_cidrs" {
  description = "List of public subnets' CIDRs"
  type = list(string)
  default = [
    "192.168.1.0/24",
    "192.168.2.0/24"]
}

variable "vpc_private_subnets_cidrs" {
  description = "List of private subnets' CIDRs"
  type = list(string)
  default = [
    "192.168.11.0/24",
    "192.168.22.0/24"]
}

variable "owner_email" {
  description = "Owner email"
  type = string
  default = "nikolai_sergeev@epam.com"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type = string
  default = "t3.micro"
}

variable "wordpress_server_role_name" {
  description = "WordPress server role name"
  type = string
  default = "wordpress_server_role"
}

variable "ssh_key_name" {
  description = "SSH key name"
  type = string
  default = "kolyaiks_iam"
}

variable "wordpress_server_max_size" {
  description = "Maximum of WP servers in ASG"
  type = number
  default = 1
}

variable "wordpress_server_min_size" {
  description = "Minimum of WP servers in ASG"
  type = number
  default = 1
}

variable "wordpress_server_desired_capacity" {
  description = "Desired capacity of WP servers in ASG"
  type = number
  default = 1
}

variable "ssh_inbound_list_allowed" {
  description = "List of CIRDs allowed to connect via SSH"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "db_instance_type" {
  description = "RDS instance type"
  type = string
  default = "db.t3.micro"
}

variable "db_multi_az"  {
  description = "Need multi AZ for RDS?"
  type = bool
  default = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot before destroy of RDS?"
  type = bool
  default = true
}

variable "db_name" {
  description = "Enter WordPress db name"
  type = string
  default = "wordpress"
}

variable "db_user" {
  description = "Enter WordPress db admin name"
  type = string
  default = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Enter WordPress db admin password"
  type = string
  default = "password"
  sensitive   = true
}

variable "wp_admin" {
  description = "Enter WordPress admin name"
  type = string
  default = "kolyaiks"
  sensitive   = true
}

variable "wp_password" {
  description = "Enter WordPress admin password"
  type = string
  default = "password"
  sensitive   = true
}

variable "wp_admin_email" {
  description = "Enter WordPress admin email"
  type = string
  default = "example_email@gmail.com"
}





