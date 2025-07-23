resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = var.vpc_name
    }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

# Public Subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.availability_zones[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public"
    }
}

# Private Subnet
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "${var.vpc_name}-private-${count.index}"
    }
}

resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id   
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
}

resource "aws_route_table_association" "private" {
    count = 2
    subnet_id = aws_subnet.private[count.index].id 
    route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "private" {
    name = "private-sg"
    description = "Allow internal traffic to RDS or private EC2"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = var.private_subnet_cidrs
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.vpc_name}-private-sg"
    }
}

