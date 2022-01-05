resource "aws_internet_gateway" "app-server-internet-gateway" {
  vpc_id = aws_vpc.app-server-vpc.id

   tags = {
    Name = "App Server Internet Gateway"
  }
}

resource "aws_route_table" "app-server-public-route-table" {
  vpc_id = aws_vpc.app-server-vpc.id
  
  depends_on = [
    aws_internet_gateway.app-server-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-server-internet-gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "app-server-public-table-association" {
  subnet_id      = aws_subnet.app-server-vpc-public.id
  route_table_id = aws_route_table.app-server-public-route-table.id
}

resource "aws_security_group" "allow-internal-http" {
  name        = "allow-internal-http"
  description = "Allow Internal HTTP requests"
  vpc_id      = aws_vpc.app-server-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app-server-vpc.cidr_block]
  }
}

resource "aws_security_group" "allow-http" {
  name        = "allow-http"
  description = "Allow External HTTP requests"
  vpc_id      = aws_vpc.app-server-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.app-server-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-all-outbound" {
  name        = "allow-all-outbound"
  description = "Allow Outbound Request"
  vpc_id      = aws_vpc.app-server-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_subnet" "app-server-vpc-public" {
  availability_zone_id = "usw2-az1"
  cidr_block           = "10.0.0.0/24"
  vpc_id               = aws_vpc.app-server-vpc.id

  tags = {
    Name = "App Server Public Subnet"
  }
}

resource "aws_subnet" "app-server-vpc-private-1" {
  availability_zone_id = "usw2-az1"
  cidr_block           = "10.0.1.0/24"
  vpc_id               = aws_vpc.app-server-vpc.id

  tags = {
    Name = "App Server Private Subnet"
  }
}

resource "aws_vpc" "app-server-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

}
