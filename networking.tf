resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[0]

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr_one
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[1]

  tags = {
    Name = "public-subnet-one"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "table" {
  vpc_id = aws_vpc.main.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.gw.id
      vpc_peering_connection_id  = null
      destination_prefix_list_id = null
      egress_only_gateway_id     = null
      instance_id                = null
      vpc_endpoint_id            = null
      ipv6_cidr_block            = null
      transit_gateway_id         = null
      local_gateway_id           = null
      nat_gateway_id             = null
      network_interface_id       = null
      carrier_gateway_id         = null
    }
  ]

  tags = {
    Name = "route table"
  }
}

resource "aws_route_table_association" "assos" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.table.id
}

resource "aws_route_table_association" "assos_one" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.table.id
}
