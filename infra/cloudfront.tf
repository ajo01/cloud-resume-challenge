
resource "aws_cloudfront_distribution" "my_cdn" {
    enabled = true

 origin {
    domain_name = "www.amyjo.cloud"
    origin_id   = "resumeOrigin"
 }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = "resumeOrigin"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }
    
  }

 restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:128126758177:certificate/d4a4f3a3-413c-4b19-80d3-caab3425ea59"  # Replace with your actual ACM certificate ARN
    ssl_support_method  = "sni-only"  # or "vip" depending on your requirements
  }

}