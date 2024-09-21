variable source_vpc_cidr_block {
    default = "192.168.0.0/16"
}

variable target_vpc_cidr_block {
    default = "10.0.0.0/16"
}

variable source_private_subnet_cidr_blocks {
    default = ["192.168.1.0/24"]
}
variable target_private_subnet_cidr_blocks {
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable source_public_subnet_cidr_blocks {
    default = ["192.168.101.0/24"]
}
variable target_public_subnet_cidr_blocks {
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "source_vpc_name" {
  default = "source-vpc"
}

variable "target_vpc_name" {
  default = "target-vpc"
}

variable aws_region {
  default = "eu-west-1"
}

variable aws_access_key_id {}
variable aws_secret_access_key {}