#create vpc
resource "aws_vpc" "ramya" {
    cidr_block = "10.0.0.0/16"
    tags = {
     Name ="project-1"
    }
}
#create internet gateway  and attach vpc
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.ramya.id
    tags = {
      Name = "project_igw"
    }
}
#create subnet-1 pub
resource "aws_subnet" "pub_sub1" {
    cidr_block = "10.0.1.0/24"
     vpc_id = aws_vpc.ramya.id
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "pub_sub1"
    }
}
#craete subnet-2 pvt
resource "aws_subnet" "pub_sub2" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.ramya.id
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "pub-sub-2"
    }
}
#Create Route Table and Attach internet Gateway
resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.ramya.id
    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "project_RT"
    }
}
#subnet assosiation public
resource "aws_route_table_association" "my_rt-1" {
    subnet_id = aws_subnet.pub_sub1.id
    route_table_id = aws_route_table.my_rt.id
}
#subnet assosiation private
resource "aws_route_table_association" "my_rt-2" {
    subnet_id = aws_subnet.pub_sub2.id
    route_table_id = aws_route_table.my_rt.id
}
#create security group
resource "aws_security_group" "my_sg" {
    vpc_id = aws_vpc.ramya.id
    description = "Allowing Jenkins, SonarQube, SSH Access"

    ingress = [  
        for port in [22, 8080, 9000, 9090, 80] : {
            description      = "TLS from VPC"
            from_port        = port
            to_port          = port
            protocol         = "tcp"
            ipv6_cidr_blocks = ["::/0"]
            self             = false
            prefix_list_ids  = []
            security_groups  = []
            cidr_blocks      = ["0.0.0.0/0"]
        }
    ]
     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "MY_SG"
    }
}