data "archive_file" "send_email" {
  type        = "zip"
  source_file = "send_email.py"
  output_path = "./zips/send_email.zip"
}


resource "aws_lambda_function" "send_email" {
  filename         = "./zips/send_email.zip"
  function_name    = "send_email"
  role             = "arn:aws:iam::077708451457:role/admin_role"
  handler          = "send_email.lambda_handler"
  runtime          = "python3.7"
  source_code_hash = "${filebase64sha256("./zips/send_email.zip")}"
}
