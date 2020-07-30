locals {
  ttl = 300
}

variable "zone_id" {
  type = string
  description = "The ID of the Route53 zone which will contain these records."
}

variable "verification_data" {
  type = string
  description = "The VERIFY key which proves to ProtonMail that you own this domain."
}

variable "dkim_records" {
  type = list(object({
    hostname = string
    data = string
  }))
  description = "The list of DKIM signing hostnames and data pairs provided by ProtonMail which will be used in CNAME records."
}

variable "dmarc_policy" {
  type = string
  description = "The action other email services should take when SPF and DKIM checks have failed."
  validation {
    condition = var.dmarc_policy == "none" || var.dmarc_policy == "quarantine" || var.dmarc_policy == "reject"
    error_message = "The DMARC policy must be either none|quarantine|reject."
  }
  default = "none"
}

variable "additional_dmarc_flags" {
  type = list(string)
  description = "Additional flags to append to the DMARC record."
}
