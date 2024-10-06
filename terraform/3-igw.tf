resource "aws_internet_gateway" "igw_source" {
  vpc_id = aws_vpc.source.id

  tags = {
    Name = "${local.env1}-igw"
  }
}

resource "aws_internet_gateway" "igw_cloud" {
  vpc_id = aws_vpc.cloud.id

  tags = {
    Name = "${local.env2}-igw"
  }
}

