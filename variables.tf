variable "domain_name" {
  default = "example.com"
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

