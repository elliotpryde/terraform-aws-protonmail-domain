# terraform-aws-protonmail-domain

## Example usage

```hcl
module "protonmail-domain" {
  source  = "app.terraform.io/elliotpryde/protonmail-domain/aws"
  version = "0.1.0"

  zone_id = aws_route53_zone.my-zone.zone_id
  verification_data = "protonmail-verification=<verification-string>"
  dkim_records = [
    {
      hostname = "protonmail._domainkey",
      data = "protonmail.domainkey.d4zotdvax2nt4447zdfl5bkm6uc3lozcidvlw5jdxq3hhurmq3u5q.domains.proton.ch."
    },
    {
      hostname = "protonmail2._domainkey",
      data = "protonmail2.domainkey.d4zotdvax2nt4447zdfl5bkm6uc3lozcidvlw5jdxq3hhurmq3u5q.domains.proton.ch."
    },
    {
      hostname = "protonmail3._domainkey",
      data = "protonmail3.domainkey.d4zotdvax2nt4447zdfl5bkm6uc3lozcidvlw5jdxq3hhurmq3u5q.domains.proton.ch."
    }
  ]
  dmarc_policy = "quarantine"
  additional_dmarc_flags = [
    "pct=100",
    "rua=mailto:dmarc.admin@somedomain.com"
  ]
}
```
