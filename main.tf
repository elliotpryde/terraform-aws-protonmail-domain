resource "aws_route53_record" "verify" {
  name = ""
  type = "TXT"
  ttl = local.ttl
  zone_id = var.zone_id

  records = [
    var.verification_data
  ]
}

resource "aws_route53_record" "mx" {
  name = ""
  type = "MX"
  ttl = local.ttl
  zone_id = var.zone_id
  records = [
    "10 mail.protonmail.ch",
    "20 mailsec.protonmail.ch"
  ]
}

resource "aws_route53_record" "spf" {
  name = ""
  type = "TXT"
  ttl = local.ttl
  zone_id = var.zone_id

  records = [
    "v=spf1 include:_spf.protonmail.ch mx ~all"
  ]
}

resource "aws_route53_record" "dkim" {
  count = length(var.dkim_records)
  name = var.dkim_records[count.index].hostname
  type = "CNAME"
  ttl = local.ttl
  zone_id = var.zone_id

  records = [
    var.dkim_records[count.index].data
  ]
}

resource "aws_route53_record" "dmarc" {
  name = "_dmarc"
  type = "TXT"
  ttl = local.ttl
  zone_id = var.zone_id

  records = [
    "v=DMARC1; p=${var.dmarc_policy}; ${join(";", var.additional_dmarc_flags)}"
  ]
}
