resource "aws_vpc" "main" {
  cidr_block = var.cidr["network"]
  tags       = var.default_tags
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr.public
  map_public_ip_on_launch = "true"
  availability_zone       = var.region
  tags                    = var.default_tags
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr.private
  map_public_ip_on_launch = "false"
  availability_zone       = var.region
  tags = var.default_tags
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.default_tags
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr["anycast"]
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = var.default_tags
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
  tags           = var.default_tags
}
