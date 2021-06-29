# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table#example-usage
resource "aws_dynamodb_table" "basic_database_automation" {
  name           = "Contacts_WM_dev_tf"
  billing_mode   = "PROVISIONED"
  hash_key       = "id"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "development"
  }
}
