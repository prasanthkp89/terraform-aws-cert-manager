locals {
  alternative_names_count = "${length(var.subject_alternative_names)}"
}

data "aws_route53_zone" "zone" {
  count        = "${local.alternative_names_count}"
  name         = "${lookup(var.subject_alternative_names[count.index], "hosted_zone_name")}"
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  count   = "${local.alternative_names_count}"
  name    = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${data.aws_route53_zone.zone.*.id[count.index]}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = 60
}

data "aws_route53_zone" "domain_zone" {
  count   = "${var.create_entry_for_domain ? 1 : 0}"
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_record" "cert_domain_validation" {
  count   = "${var.create_entry_for_domain ? 1 : 0}"
  
  name    = "${lookup(aws_acm_certificate.cert.domain_validation_options[length(aws_acm_certificate.cert.domain_validation_options) - 1], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.cert.domain_validation_options[length(aws_acm_certificate.cert.domain_validation_options) - 1], "resource_record_type")}"
  zone_id = "${data.aws_route53_zone.domain_zone[count.index]}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[length(aws_acm_certificate.cert.domain_validation_options) - 1], "resource_record_value")}"]
  ttl     = 60

}

resource "aws_acm_certificate_validation" "cert" {  
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  depends_on = ["aws_route53_record.cert_validation", "aws_route53_record.cert_domain_validation"]
}
