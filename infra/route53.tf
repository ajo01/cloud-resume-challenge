

resource "aws_route53_zone" "resume_zone" {

  # The configuration will be filled out after import
}

resource "aws_route53_record" "resume_record" {
  zone_id = aws_route53_zone.resume_zone.id
  name    = "www.amyjo.cloud"

}
