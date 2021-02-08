data "aws_acm_certificate" "ssl_cert" {
  domain = var.ROOT_DOMAIN
  statuses = ["ISSUED"]
  provider = aws.virginia
}
