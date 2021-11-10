resource "aws_iam_role" "test-role" {

  name = "${var.environment}-ci-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "${var.account}"
        }
      },
    ]
  })
  tags = {
      environment = var.environment
      managed_by_terraform = "true"

  }
}

resource "aws_iam_policy" "test-policy" {
    name = "${var.environment}-ci-policy"
    depends_on = [
      aws_iam_role.test-role
    ]
    description = "Policy for assuming newly created role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.test-role.arn
      },
    ]
  })
  tags = {
      environment = var.environment
      managed_by_terraform = "true"

  }
}
resource "aws_iam_group" "ci-group" {
    name = "${var.environment}-ci"

}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.ci-group.name
  policy_arn = aws_iam_policy.test-policy.arn
}

resource "aws_iam_user" "ci-user" {
  name = "${var.environment}-ci-user"
}

resource "aws_iam_user_group_membership" "group-membership" {
  user = aws_iam_user.ci-user.name

  groups = [
    aws_iam_group.ci-group.name
  ]
}

resource "aws_iam_access_key" "ci-user-key" {
  user = aws_iam_user.ci-user.name
}
