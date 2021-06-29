variable "aws_region" {
  type        = string
  description = "The region of the AWS Services."
  default     = "us-east-1"
}

variable "create_build" {
  type        = string
  description = "The lambda compressed file path"
  default     = "../../../../Onboarding/create-contact-aws-lambda/create-contact-aws-lambda.zip"
}
