resource "aws_lambda_function" "create_contact_function" {
  function_name    = "create_contact-aws-lambda-dev-WM-tf"
  handler          = "create-contact-aws-lambda"
  runtime          = "go1.x"
  filename         = var.create_build
  source_code_hash = base64sha256("${var.create_build}")
  role             = aws_iam_role.role_for_lambda.arn
  memory_size      = 128
  timeout          = 10
}

resource "aws_cloudwatch_log_group" "logger" {
  name              = "/aws/lambda/${aws_lambda_function.create_contact_function.function_name}"
  retention_in_days = 1
}
