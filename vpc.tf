locals {
  azs                = "${data.aws_availability_zones.azs.names}"
  public_subnet_ids  = "${aws_subnet.main.*.id}"
  private_subnet_ids = "${aws_subnet.private.*.id}"
}

# Create VPC for our app

resource "aws_vpc" "myapp_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"
  tags             = "${var.vpc_tags}"
}

# Create public subnets

resource "aws_subnet" "main" {
  count                   = "${length(local.azs)}"
  vpc_id                  = "${aws_vpc.myapp_vpc.id}"
  cidr_block              = "${element(var.subnet_cidrs, count.index)}"
  availability_zone       = "${element(local.azs, count.index)}"
  map_public_ip_on_launch = true
  tags                    = "${var.public_sub_tags}"
}

# Create Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myapp_vpc.id}"

  tags = {
    Name = "javhome-igw"
  }
}

# Create custom route table for public subent

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.myapp_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "public-routetable"
  }
}

# associate public subnets with public route table

resource "aws_route_table_association" "a" {
  count          = "${length(local.azs)}"
  subnet_id      = "${element(local.public_subnet_ids, count.index)}"
  route_table_id = "${aws_route_table.r.id}"
}

# Create 2 private subnets
resource "aws_subnet" "private" {
  count             = "2"
  vpc_id            = "${aws_vpc.myapp_vpc.id}"
  cidr_block        = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone = "${element(local.azs, count.index)}"
  tags              = "${var.private_sub_tags}"
}



resource "aws_route_table" "prt" {
  vpc_id = "${aws_vpc.myapp_vpc.id}"
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
  tags = {
    Name = "private-routetable"
  }
}

# associate private subnets with private route table

resource "aws_route_table_association" "pa" {
  count          = "2"
  subnet_id      = "${element(local.private_subnet_ids, count.index)}"
  route_table_id = "${aws_route_table.prt.id}"
}
