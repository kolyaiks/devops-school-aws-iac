resource "aws_iam_role" "wordpress_server_role" {
  name = var.wordpress_server_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = var.wordpress_server_role_name
    owner = var.owner_email
    env = var.env
  }
}

resource "aws_iam_instance_profile" "wordpress_server_instance_profile" {
  name = "wordpress_server_instance_profile"
  role = aws_iam_role.wordpress_server_role.name
}