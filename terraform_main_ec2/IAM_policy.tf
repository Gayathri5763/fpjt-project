#create policy attach to role
resource "aws_iam_role_policy_attachment" "policy" {
    role = aws_iam_role.my_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}