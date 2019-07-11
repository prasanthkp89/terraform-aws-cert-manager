variable "domain_name" {
  default = "example.com"
}
variable "aws_region" {
  default = "eu-west-1"
}

variable "subject_alternative_names" {
  type = "list"
  default = [
    {
      "name" =  "*.example.com",
      "hosted_zone_name" = "example.com."
    }
  ]
}

variable "create_entry_for_domain" {
  default = false
}

