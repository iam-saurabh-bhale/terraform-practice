resource "aws_vpc" "Prod-VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "Prod-VPC"
    }
}

resource "aws_subnet" "public-subnet-prod" {
  vpc_id = aws_vpc.Prod-VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true  
  tags = {
    Name = "public-subnet-prod"
  }
}

resource "aws_subnet" "private-subnet-prod" {
  vpc_id = aws_vpc.Prod-VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-prod"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id =  aws_vpc.Prod-VPC.id
  tags = {
    Name = "igw-prod-main"
  }
}

resource "aws_eip" "nat-eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.public-subnet-prod.id
  depends_on = [ aws_eip.nat-eip ]
  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "public" {
vpc_id = aws_vpc.Prod-VPC.id

tags = {
Name = "public-route-table"
}
}

resource "aws_route" "public_internet" {
route_table_id         = aws_route_table.public.id
destination_cidr_block = "0.0.0.0/0"
gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
subnet_id      = aws_subnet.public-subnet-prod.id
route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
vpc_id = aws_vpc.Prod-VPC.id

tags = {
Name = "private-route-table"
}
}

resource "aws_route" "private_nat" {
route_table_id         = aws_route_table.private.id
destination_cidr_block = "0.0.0.0/0"
nat_gateway_id         = aws_nat_gateway.nat-gateway.id
}

resource "aws_route_table_association" "private" {
subnet_id      = aws_subnet.private-subnet-prod.id
route_table_id = aws_route_table.private.id
}