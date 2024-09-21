module "source_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.source_vpc_name
  cidr = var.source_vpc_cidr_block

  azs             = data.aws_availability_zones.available.names 
  private_subnets = var.source_private_subnet_cidr_blocks
  public_subnets  = var.source_public_subnet_cidr_blocks

  enable_nat_gateway = true
  enable_dns_hostnames = true


  tags = {
    Environment = "on-premises"
  }
}

module "target_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name =  var.target_vpc_name
  cidr = var.target_vpc_cidr_block

  azs             = data.aws_availability_zones.available.names 
  private_subnets = var.target_private_subnet_cidr_blocks
  public_subnets  = var.target_public_subnet_cidr_blocks

  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  enable_dns_hostnames = true



  tags = {
    Environment = "cloud"
  }
}