# launch ec2 instances in to public subnets


resource "aws_instance" "web" {
  count                  = 2
  ami                    = "${lookup(var.web_ami, var.region)}"
  instance_type          = "t2.micro"
  subnet_id              = "${local.public_subnet_ids[count.index]}"
  key_name               = "kubernetes"
  user_data              = "${file("apache.sh")}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  tags = {
    Name = "Webserver-${count.index + 1}"
  }
}
