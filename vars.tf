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
