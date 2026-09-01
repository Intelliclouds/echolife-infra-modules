# Create an IP Set for known malicious IPs that we want to explicitly block
resource "aws_wafv2_ip_set" "blocked_ips" {
  name               = "echolife-${var.environment}-blocked-ips"
  description        = "List of explicitly blocked IP addresses"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  
  # You can add malicious CIDRs here in the future
  addresses = [] 
}
