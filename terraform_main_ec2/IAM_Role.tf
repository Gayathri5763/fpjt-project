#create iam role
resource "aws_iam_role" "my_role" {
   name = "test_role"
   assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
     {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "ec2.amazonaws.com"
        }
      }
    ]
  }
  EOF

  
}