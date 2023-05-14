resource "aws_acm_certificate" "ssl_certificate" {
  domain_name               = var.ROOT_DOMAIN
  subject_alternative_names = ["*.${var.ROOT_DOMAIN}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "acm"
  }
}
