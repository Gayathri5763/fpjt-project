#iam role attach to instance
resource "aws_iam_instance_profile" "instance_profile" {
    role = aws_iam_role.my_role.name
    name = "ramya_instance_profile"
  
}