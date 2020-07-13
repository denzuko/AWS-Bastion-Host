
resource "aws_vpc" "main" {
  cidr_block = var.cidr["network"]
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr["public"]
  map_public_ip_on_launch = "true"
  availability_zone       = var.region

  tags = {
    Name = "public-subnet"
    net.matrix.application  = var.cmdb["application"]
    net.matrix.costcenter   = var.cmdb["costcenter"]
    net.matrix.customer     = var.cmdb["customer"]
    net.matrix.duns         = var.cmdb["duns"]
    net.matrix.environment  = var.cmdb["environment"]
    net.matrix.oid          = var.cmdb["oid"]
    net.matrix.organization = var.cmdb["organization"]
    net.matrix.orgunit      = var.cmdb["orgunit"]
    net.matrix.owner        = var.cmdb["owner"]
    net.matrix.region       = var.region
    net.matrix.role         = var.cmdb["role"]
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr["private"]
  map_public_ip_on_launch = "false"
  availability_zone       = var.region

  tags = {
    Name = "private-subnet"
    net.matrix.application  = var.cmdb["application"]
    net.matrix.costcenter   = var.cmdb["costcenter"]
    net.matrix.customer     = var.cmdb["customer"]
    net.matrix.duns         = var.cmdb["duns"]
    net.matrix.environment  = var.cmdb["environment"]
    net.matrix.oid          = var.cmdb["oid"]
    net.matrix.organization = var.cmdb["organization"]
    net.matrix.orgunit      = var.cmdb["orgunit"]
    net.matrix.owner        = var.cmdb["owner"]
    net.matrix.region       = var.region
    net.matrix.role         = var.cmdb["role"]
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gw"
    net.matrix.application  = var.cmdb["application"]
    net.matrix.costcenter   = var.cmdb["costcenter"]
    net.matrix.customer     = var.cmdb["customer"]
    net.matrix.duns         = var.cmdb["duns"]
    net.matrix.environment  = var.cmdb["environment"]
    net.matrix.oid          = var.cmdb["oid"]
    net.matrix.organization = var.cmdb["organization"]
    net.matrix.orgunit      = var.cmdb["orgunit"]
    net.matrix.owner        = var.cmdb["owner"]
    net.matrix.region       = var.region
    net.matrix.role         = var.cmdb["role"]
  }
}

"${var.image_id[var.region]}"

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr["anycast"]
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
