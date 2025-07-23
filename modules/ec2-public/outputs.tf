output "sg_id" {
    description = "Security Group ID of public EC2"
    value = aws_security_group.sg.id
}

output "public_ip" {
    description = "Public IP of the EC2 instance"
    value = aws_instance.ec2.public_ip
}