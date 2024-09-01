
resource "aws_cloudfront_distribution" "my_cdn" {
    enabled = true
    is_ipv6_enabled = true
    aliases = ["amyjo.cloud", "www.amyjo.cloud"]
    default_root_object = "index.html"

 origin {
    domain_name = "www.amyjo.cloud.s3-website.ca-central-1.amazonaws.com"
    origin_id   = "resumeOrigin"
    
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["SSLv3", "TLSv1","TLSv1.1","TLSv1.2"]
    }
 }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    compress = true
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
    minimum_protocol_version = "TLSv1.2_2021" 
  }

}