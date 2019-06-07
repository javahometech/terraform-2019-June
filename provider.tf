provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "javahome-tf-may"
    key    = "dev/javahomeapp/terraform.tfstate"
    region = "ap-south-1"
  }
}
