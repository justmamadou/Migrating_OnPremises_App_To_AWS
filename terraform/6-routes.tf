resource "aws_route_table" "private" {
  vpc_id = aws_vpc.cloud.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${locals.env2}-private"
  }
}

resource "aws_route_table" "public_cloud" {
  vpc_id = aws_vpc.cloud.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_cloud.id 
  }

  tags= {
    Name = "${locals.env2}-public"
  }
}

resource "aws_route_table" "public_source" {
  vpc_id = aws_vpc.source.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_source.id
  }

  tags= {
    Name = "${locals.env1}-public"
  }
}

resource "aws_route_table_association" "private_zone1" {
  subnet_id = aws_subnet.private_zone1_cloud.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_zone2" {
  subnet_id = aws_subnet.private_zone2_cloud.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_zone1" {
  subnet_id = aws_subnet.public_zone1_cloud.id
  route_table_id = aws_route_table.public_cloud.id
}

resource "aws_route_table_association" "public_zone2" {
  subnet_id = aws_subnet.public_zone2_cloud.id 
  route_table_id = aws_route_table.public_cloud.id
}

resource "aws_route_table_association" "public_source" {
  subnet_id = aws_subnet.public_zone1_source.id
  route_table_id = aws_route_table.public_source.id
}