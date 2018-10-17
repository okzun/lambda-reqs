resource "aws_lambda_function" "lambda" {
  function_name = "${var.project_name}-lambda"
  s3_bucket = "${var.artifact_bucket}"
  s3_key    = "${var.artifact_path}/output.zip"
  handler = "${var.lambda_handler}"
  runtime = "${var.lambda_runtime}"
  role = "${aws_iam_role.lambda-exec.arn}"
}

resource "aws_iam_role" "lambda-exec" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}