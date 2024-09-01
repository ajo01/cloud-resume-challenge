resource "aws_dynamodb_table" "visitorcount_db" {
  name         = "cloudresume"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

attribute {
    name = "id"
    type = "S"  # S = String, N = Number, B = Binary
  }

}