
resource "aws_cloudfront_distribution" "my_cdn" {
 origin {
    domain_name = "www.amyjo.cloud"
    origin_id   = "resumeOrigin"
 }

 viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
}