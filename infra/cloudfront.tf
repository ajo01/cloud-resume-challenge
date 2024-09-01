
resource "aws_cloudfront_distribution" "my_cdn" {
 origin {
    domain_name = "www.amyjo.cloud"
    origin_id   = "resumeOrigin"
 }

}