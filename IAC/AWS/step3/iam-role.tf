# lambda role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function#basic-example
resource "aws_iam_role" "role_for_lambda" {
  name               = "iam_role_dev_WM-tf"
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

# lambda policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function#basic-example
resource "aws_iam_policy" "iam_policy_for_lambda" {
  name = "lambda_policy_dev_WM-tf"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "LambdaPolicy",
        "Effect": "Allow",
        "Action": [
          "cloudwatch:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem",
          "dynamodb:GetRecords",
          "sns:*"
        ],
        "Resource": "*"
      }
    ]
  }
EOF
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  role       = aws_iam_role.role_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}
