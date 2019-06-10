# Declare variable

variable "vpc_cidr" {
  description = "Choose cidr for VPC"
  type        = "string"
  default     = "10.0.0.0/16"
}
variable "vpc_tenancy" {
  type        = "string"
  description = "Choose tenancy for VPC"
  default     = "default"
}
variable "vpc_tags" {
  type = "map"
  default = {
    Name     = "terraform-vpc"
    Batch    = "930AM"
    Location = "Banglore"
  }
}

# tags for public subnets

variable "public_sub_tags" {
  type = "map"
  default = {
    Name = "public-subnet"
  }
}

variable "subnet_cidrs" {
  description = "Choose cidr for public subnets"
  type        = "list"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Choose cidr for public subnets"
  type        = "list"
  default     = ["10.0.6.0/24", "10.0.7.0/24"]
}

variable "private_sub_tags" {
  type = "map"
  default = {
    Name = "private-subnet"
  }
}

variable "region" {
  default = "ap-south-1"
}

variable "nat_amis" {
  type = "map"
  default = {
    ap-south-1     = "ami-00b3aa8a93dd09c13"
    ap-southeast-1 = "ami-0096082b44d750d5d"
  }
}

variable "web_ami" {
  type = "map"
  default = {
    ap-south-1     = "ami-00e782930f1c3dbc7"
    ap-southeast-1 = "ami-0b5a47f8865280111"
  }
}
