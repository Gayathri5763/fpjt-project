output "public_ip" {
    value = aws_instance.ramya.public_ip
}
output "private_ip" {
    value = aws_instance.ramya.private_ip
}
