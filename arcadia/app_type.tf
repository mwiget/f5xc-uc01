resource "volterra_app_type" "arcadia" {
  name      = format("%s-arcadia", var.project_prefix)
  namespace = "shared"

  business_logic_markup_setting {
    enable = true
  }
  features {
    type = "BUSINESS_LOGIC_MARKUP"
  }
  features {
    type = "TIMESERIES_ANOMALY_DETECTION"
  }
  features {
    type = "PER_REQ_ANOMALY_DETECTION"
  }
  features {
    type = "USER_BEHAVIOR_ANALYSIS"
  }
}
