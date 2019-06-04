provider "aws" {
  region = "ap-south-1"
}

# Create VPC

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name  = "main"
    Batch = "930AM"
  }
}
