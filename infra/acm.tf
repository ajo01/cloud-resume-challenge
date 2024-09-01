resource "aws_acm_certificate" "resume_certificate" {
    provider = aws.acm_provider

    domain_name       = "amyjo.cloud"
  validation_method = "DNS" 
}
