resource "aws_s3_bucket" "resume_bucket" {
  
  bucket = "www.amyjo.cloud"
  acl    = "public-read"
  
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET","HEAD"]
    allowed_origins = ["*"]
    expose_headers  = [""]
  }

  website {
    index_document = "index.html"
    error_document = "index.html"

  }

  lifecycle {
    prevent_destroy = true
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