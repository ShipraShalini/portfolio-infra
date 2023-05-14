resource "aws_cloudfront_distribution" "web_cloudfront_distribution" {
  enabled             = true
  default_root_object = "index.html"
  default_cache_behavior {
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.APP_DOMAIN
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases = [var.APP_DOMAIN, "www.${var.APP_DOMAIN}"]

  origin {
    domain_name = aws_s3_bucket_website_configuration.s3_bucket.website_endpoint
    origin_id   = var.APP_DOMAIN
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.ssl_certificate.arn
    ssl_support_method  = "sni-only"
  }
  tags = {
    Name = "cloudfront"
  }
}
