resource "aws_security_group" "sg" {
    name = "${var.name_prefix}-private-sg"
    description = "Allow SSH from bastion (public EC2)"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [var.bastion_sg_id]   # Only allow SSH from public EC2 SG
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.name_prefix}-private-sg"
    }
}

resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.sg.id]

    associate_public_ip_address = false
    
    tags = {
        Name = "${var.name_prefix}-private-ec2"
    }
    
}