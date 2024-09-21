module "source_webserver_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "source-web-instance"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.source_web_server_sg.security_group_id]
  subnet_id              = element(module.source_vpc.public_subnets, 0) # Le premier sous-réseau public

  tags = {
    Environment = "on-premises"
  }
}

module "source_db_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "source-db-instance"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.source_database_sg.security_group_id]
  subnet_id              = element(module.source_vpc.private_subnets, 0) # Le premier sous-réseau public

  tags = {
    Environment = "on-premises"
  }
}


