resource "aws_wafv2_web_acl" "main" {
  name        = "echolife-${var.environment}-waf"
  description = "WAF for EchoLife API Gateway"
  scope       = "REGIONAL" 

  default_action {
    allow {}
  }

  # ---------------------------------------------------------
  # Rule 1: Custom Blocklist (References rules.tf)
  # ---------------------------------------------------------
  rule {
    name     = "ExplicitIPBlocklist"
    priority = 1

    action {
      block {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.blocked_ips.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockedIPsMetric"
      sampled_requests_enabled   = true
    }
  }

  # ---------------------------------------------------------
  # Rule 2: IP Rate Limiting (Protects Kong from floods)
  # ---------------------------------------------------------
  rule {
    name     = "RateLimit"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 2000 # Blocks IPs making >2000 requests per 5 minutes
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitMetric"
      sampled_requests_enabled   = true
    }
  }

  # ---------------------------------------------------------
  # Rule 3: AWS Managed Core Rule Set (SQLi, XSS, etc.)
  # ---------------------------------------------------------
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSCommonRulesMetric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "echolife-${var.environment}-waf-main-metrics"
    sampled_requests_enabled   = true
  }
}

# Attach the WAF to the Application Load Balancer
resource "aws_wafv2_web_acl_association" "alb" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}
