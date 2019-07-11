# terraform-aws-cert-manager

Create and validate AWS ACM certificate with Route53

## Configration

The module supports the following configurations

|-------------------------|-----------|-------------|------------|
|Name                     | Type      | Default     | Description|
|domain_name              | String    | example.com | The parent domain name for all the alternative names for which certificate is needed |
|aws_region               | String    | eu-west-1   | The region in which certificate should be created|
|subject_alternative_names| list[map] | {"name" =  "*.example.com", "hosted_zone_name" = "example.com."} | A list of alternative names and the name of corresponding hosting zone they belong to. |
| create_entry_for_domain | Boolean   | false       | Whether entry in the main hosted zone is needed or not. It is only needed when certificate is being generated for a sub hosted zone and parent hosted zone doesn't already have the entry.|
