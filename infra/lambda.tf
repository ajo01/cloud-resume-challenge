resource "aws_lambda_function" "viewcounter" {
  function_name = "cloudresume_viewcounter"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.8"

  filename      = "index.zip"

  source_code_hash = filebase64sha256("index.zip")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}


# for logging
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-execution-policy"
  description = "Policy for Lambda execution"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}


# Adding the Lambda Function URL
resource "aws_lambda_function_url" "viewcounter_url" {
  function_name       = aws_lambda_function.viewcounter.function_name
  authorization_type  = "NONE"  # No authorization; adjust if needed

  cors {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST"]
  }
}

# Output the Function URL
output "lambda_function_url" {
  value = aws_lambda_function_url.viewcounter_url.function_url
}