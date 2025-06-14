resource "aws_iam_role" "main" {
  name = "${var.name}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })


  tags = {
    tag-key = "${var.name}-role"
  }
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.name}-role"
  role = aws_iam_role.main.name
}

resource "aws_iam_role_policy" "inline-policy" {
  name = "inline-policy"
  role = aws_iam_role.main.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = concat(var.dummy_policy,var.policy_actions)
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}

