resource "aws_route53_record" "records" {
  for_each = var.create_zone ? var.records : {}

  zone_id = aws_route53_zone.main[0].zone_id
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl

  records = each.value.records
}

resource "aws_route53_record" "alb" {
  count = (
    var.create_zone &&
    var.enable_alias_records &&
    var.alb_dns_name != "" &&
    var.alb_zone_id != ""
  ) ? 1 : 0

  zone_id = aws_route53_zone.main[0].zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
