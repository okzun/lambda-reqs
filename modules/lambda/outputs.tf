output "lambda_arn" {
  description = "Lambda ARN"
  value       = "${aws_lambda_function.lambda.arn}"
}