resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)  # שימוש באזורי זמינות שונים
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)  # שימוש באזורי זמינות שונים

  tags = {
    Name = "${var.env_name}-private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.env_name}-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.env_name}-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id
  description = "Main security group for VPC"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_name}-sg"
  }
}

