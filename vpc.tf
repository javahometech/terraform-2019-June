locals {
  azs = "${data.aws_availability_zones.azs.names}"
}

# Create VPC for our app

resource "aws_vpc" "myapp_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"
  tags             = "${var.vpc_tags}"
}

# Create public subnets

resource "aws_subnet" "main" {
  count             = "${length(local.azs)}"
  vpc_id            = "${aws_vpc.myapp_vpc.id}"
  cidr_block        = "${element(var.subnet_cidrs, count.index)}"
  availability_zone = "${element(local.azs, count.index)}"
  tags              = "${var.public_sub_tags}"
}
