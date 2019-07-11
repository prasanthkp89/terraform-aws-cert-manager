data "template_file" "subject_alternative_names_only" {
  count = "${length(var.subject_alternative_names)}"
  template = "${lookup(var.subject_alternative_names[count.index], "name")}"
}
resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.domain_name}"
  subject_alternative_names = ["${data.template_file.subject_alternative_names_only.*.rendered}"]
  validation_method = "DNS"
}
