resource "aws_instance" "webserver_source" {
  ami           = "ami-0d64bb532e0502c46"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver_sg_source.id]
  subnet_id = aws_subnet.public_zone1_source.id

  //user_data = file("${path.module}/../Install_wordpress.sh")

  tags = {
    "Name"= "${local.env1}-${local.az1}"
  }
}

resource "aws_instance" "webserver_cloud" {
  ami           = "ami-0d64bb532e0502c46"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver_sg_cloud.id]
  subnet_id = aws_subnet.public_zone1_cloud.id

  //user_data = file("${path.module}/../Install_wordpress.sh")

  tags = {
    "Name"= "${local.env2}-${local.az2}"
  }
}
