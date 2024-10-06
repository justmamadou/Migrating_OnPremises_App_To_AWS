resource "aws_internet_gateway" "igw_source" {
  vpc_id = aws_vpc.source.id

  tags = {
    Name = "${locals.env1}-igw"
  }
}

resource "aws_internet_gateway" "igw_target" {
  vpc_id = aws_vpc.cloud.id

  tags = {
    Name = "${locals.env2}-igw"
  }
}

