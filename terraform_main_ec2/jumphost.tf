#create  jumphost server means main server/instance
resource "aws_instance" "ramya" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.large"
    key_name = "maven"
    subnet_id = aws_subnet.pub_sub1.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    associate_public_ip_address = true
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name
    root_block_device {
      volume_size = 30
    }
    user_data = templatefile("./install_tools.sh", {})

    tags = {
      Name = "Main-Project"
    }
    
}