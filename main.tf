provider "aws" {
  region     = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "yogi-tf"
    key    = "terraform-backend/ec2-creation.tf"
    region = "ap-south-1"
  }
}

data "aws_vpc" "yogi-vpc"{

filter {
 name = "tag:Name"
 values = ["Yogi-VPC-DevOps"]
}
}

data "aws_availability_zones" "yogi-az" {
  state = "available"
}

data aws_subnets "public-subnets" {
 //vpc_id = data.aws_vpc.yogi-vpc.id

  //filter {
  // name   = "vpc-id"
  // values = ["data.aws_vpc.yogi-vpc.id"] 
 // }
  tags = {
   Name = "Public-subnet-*"
  }
}

data "aws_subnet" "vpcsubnet" {
  for_each = { for index, subnetid in data.aws_subnets.public-subnets.ids : index => subnetid }
  id       = each.value
}
 

output "ids2" {
  value = [
    for v in data.aws_subnet.vpcsubnet : v.ids
  ]
}



