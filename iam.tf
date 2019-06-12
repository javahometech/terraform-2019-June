data "template_file" "s3_policy" {
  template = "${file("ec2_s3_policy.json")}"
  vars = {
    s3_bucket_arn = "${var.s3_bucket_arn}"
  }
}


resource "aws_iam_policy" "policy" {
  name        = "tf_policy_s3"
  path        = "/"
  description = "read write access to s3"

  policy = "${data.template_file.s3_policy.rendered}"
}

resource "aws_iam_role" "ec2_policy" {
  name = "tf_s3_role_for_ec2"

  assume_role_policy = "${file("ec2_assume_role.json")}"

  tags = {
    tag-key = "tf_s3_role_for_ec2"
  }
}

# Attache Policy and IAM Role

resource "aws_iam_role_policy_attachment" "s3_ec2_attach" {
  role       = "${aws_iam_role.ec2_policy.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

# Create IAM instance profile

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "tf_s3_role_for_ec2"
  role = "${aws_iam_role.ec2_policy.name}"
}
