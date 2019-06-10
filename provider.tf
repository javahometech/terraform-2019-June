provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "hari-mphasis"
    key    = "dev/javahomeapp/terraform.tfstate"
    region = "ap-south-1"
  }
}
