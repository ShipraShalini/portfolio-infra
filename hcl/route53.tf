data "aws_route53_zone" "zone" {
  name = var.ROOT_DOMAIN
  private_zone = false
}

resource "aws_route53_record" "web_record" {
  name = var.APP_DOMAIN
  type = "A"
  zone_id = data.aws_route53_zone.zone.id
  alias {
    evaluate_target_health = false
    name = aws_cloudfront_distribution.web_cloudfront_distribution.domain_name
    zone_id = aws_cloudfront_distribution.web_cloudfront_distribution.hosted_zone_id
  }
}
