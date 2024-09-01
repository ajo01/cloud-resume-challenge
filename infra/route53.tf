

resource "aws_route53_zone" "resume_zone" {
    name    = "www.amyjo.cloud"
}



resource "aws_route53_record" "resume_record" {
     zone_id = aws_route53_zone.resume_zone.id
    name = "www.amyjo.cloud" 
    records  = [
          "ns-1433.awsdns-51.org.",
          "ns-1557.awsdns-02.co.uk.",
          "ns-593.awsdns-10.net.",
          "ns-86.awsdns-10.com.",
        ] 
    type = "NS"
    ttl = 172800
}
