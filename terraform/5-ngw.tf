resource "aws_eip" "nat_ip" {
  domain = "vpc"

  tags = {
    Name = "${local.env2}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id = aws_subnet.public_zone1_cloud.id
  tags = {
    Name = "${local.env2}-nat"
  }

  depends_on = [ aws_internet_gateway.igw_cloud ]
}