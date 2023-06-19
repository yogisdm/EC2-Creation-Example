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
  //  name   = "tag:Name"
  //  values = ["Public-k8s-*"] 
  //}
  tags = {
   Name = "Public-subnet-*"
  }
}





