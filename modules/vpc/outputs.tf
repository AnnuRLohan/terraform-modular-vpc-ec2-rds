output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet_id" {
    value = aws_subnet.public.id
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
}

output "private_sg_id" {
    value = aws_security_group.private.id
}