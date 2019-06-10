resource "aws_instance" "nat" {
  ami                    = "${lookup(var.nat_amis, var.region, "ap-south-1")}"
  instance_type          = "t2.micro"
  subnet_id              = "${local.public_subnet_ids[0]}"
  source_dest_check      = false
  vpc_security_group_ids = ["${aws_security_group.nat.id}"]
  key_name               = "kubernetes"
  tags = {
    Name = "Nat Instance"
  }
}
