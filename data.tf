data "aws_availability_zones" "azs" {}

data "aws_ami" "latest_amazon_linux_2" {
  owners = [
    "137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}