terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.47"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


# lambda role
resource "aws_iam_role" "iam_role_for_lambda" {
  name               = "lambda-invoke-role-WM"
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
} # lambda policy
resource "aws_iam_policy" "iam_policy_for_lambda" {
  name   = "lambda-invoke-policy-WM"
  path   = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "LambdaPolicy",
        "Effect": "Allow",
        "Action": [
          "cloudwatch:*",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "logs:*",
          "xray:PutTelemetryRecords",
          "xray:PutTraceSegments",
          "dynamodb:*",
          "sns:*"
        ],
        "Resource": "*"
      }
    ]
  }
EOF
} # Attach the policy to the role
resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  role       = aws_iam_role.iam_role_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "dummyapp-dev-WM-tf" {
  function_name    = "dummyapp-aws-lambda-dev-WM-tf"
  handler          = "dummy-app-WM-aws-lambda"
  runtime          = "go1.x"
  filename         = "../dummy-app/dummy-app-WM-aws-lambda.zip"
  source_code_hash = base64sha256("../dummy-app/dummy-app-WM-aws-lambda.zip")
  role             = aws_iam_role.iam_role_for_lambda.arn
  memory_size      = 128
  timeout          = 10
}
