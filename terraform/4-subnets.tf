resource "aws_subnet" "private_zone1_cloud" {
  vpc_id = aws_vpc.cloud.id
  cidr_block = "192.168.0.0/19"
  availability_zone = local.az1

  tags = {
    "Name" = "${local.env2}-private-${local.az1}"
  }
}

resource "aws_subnet" "private_zone2_cloud" {
  vpc_id = aws_vpc.cloud.id
  cidr_block = "192.168.32.0/19"
  availability_zone = local.az2

  tags = {
    "Name" = "${local.env2}-private-${local.az2}"
  }
}

resource "aws_subnet" "public_zone1_cloud" {
  vpc_id = aws_vpc.cloud.id
  cidr_block = "192.168.64.0/19"
  availability_zone = local.az1
  map_public_ip_on_launch = true

  tags = {
    "Name"= "${local.env2}-public-${local.az1}"
  }
}

resource "aws_subnet" "public_zone2_cloud" {
  vpc_id = aws_vpc.cloud.id
  cidr_block = "192.168.96.0/19"
  availability_zone = local.az2
  map_public_ip_on_launch = true

  tags = {
    "Name"= "${local.env2}-public-${local.az2}"
  }
}

resource "aws_subnet" "public_zone1_source" {
  vpc_id = aws_vpc.source.id
  cidr_block = "10.0.0.0/19"
  availability_zone = local.az1
  map_public_ip_on_launch = true

  tags = {
    "Name"= "${local.env1}-public-${local.az1}"
  }
}