resource "aws_s3_bucket" "resume_bucket" {
  bucket = "www.amyjo.cloud"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "resume_bucket_acl" {
  bucket = aws_s3_bucket.resume_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "resume_bucket_website" {
  bucket = aws_s3_bucket.resume_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "resume_bucket_cors" {
  bucket = aws_s3_bucket.resume_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = [""]
  }
}


resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.resume_bucket.bucket

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.resume_bucket.bucket}/*"
    }
  ]
}
EOF
}