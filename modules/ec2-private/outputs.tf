output "private_ip" {
    description = "Private IP of private EC2"
    value = aws_instance.ec2.private_ip
}

output "ec2_id" {
    value = aws_instance.ec2.id
}