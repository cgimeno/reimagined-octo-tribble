output "key" {
    value = aws_iam_access_key.ci-user-key
    description = "Key for newly created user"
    sensitive = true
}