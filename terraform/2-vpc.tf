resource "aws_vpc" "source" {
    cidr_block = "10.0.0.0/16"

    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "${local.env1}-main"
    }
  
}

resource "aws_vpc" "cloud" {
    cidr_block = "192.168.0.0/16"

    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "${local.env2}-main"
    }
  
}