resource "aws_security_group" "webserver_sg_source" {
  name        = "${local.env1}-sg"
  description = "Allow http, mysql inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.source.id

  tags = {
    "Name"= "${local.env1}-sg"
  }
}

resource "aws_security_group" "webserver_sg_cloud" {
  name        = "${local.env2}-sg"
  description = "Allow http, mysql inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.cloud.id

  tags = {
    "Name"= "${local.env2}-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_http_source" {
  security_group_id = aws_security_group.webserver_sg_source.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_source" {
  security_group_id = aws_security_group.webserver_sg_source.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_source" {
  security_group_id = aws_security_group.webserver_sg_source.id
  cidr_ipv4         = aws_vpc.source.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_source" {
  security_group_id = aws_security_group.webserver_sg_source.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_cloud" {
  security_group_id = aws_security_group.webserver_sg_cloud.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_cloud" {
  security_group_id = aws_security_group.webserver_sg_cloud.id
  cidr_ipv4         = aws_vpc.cloud.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_cloud" {
  security_group_id = aws_security_group.webserver_sg_cloud.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}