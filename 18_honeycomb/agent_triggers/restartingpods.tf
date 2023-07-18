
resource "honeycombio_query" "restartingpods" {
  dataset    = var.dataset
  query_json = <<-EOT
{
    "time_range": 600,
    "granularity": 0,
    "breakdowns": [],
    "calculations": [
        {
            "op": "SUM",
            "column": "status.restart_delta"
        }
    ],
    "orders": [],
    "havings": []
}
  EOT
}

resource "honeycombio_trigger" "restartingpods" {
  name        = "Pods are restarting too often (honeycomb-agent)"
  description = "Pods on the cluster are restarting too often.  Honeycomb Agent based."

  query_id = honeycombio_query.restartingpods.id
  dataset  = var.dataset

  frequency = 180 // in seconds, ~3 minutes

  alert_type = "on_change" // on_change is default, on_true can refers to the "Alert on True" checkbox in the UI

  threshold {
    op    = ">="
    value = 2
  }

  # zero or more recipients
  recipient {
    type   = "slack"
    target = "#test-alert"
  }

  recipient {
    type   = "marker"
    target = "Trigger - Too many restarts detected"
  }
}
