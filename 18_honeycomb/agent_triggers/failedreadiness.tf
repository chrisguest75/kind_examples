
resource "honeycombio_query" "failedreadiness" {
  dataset    = var.dataset
  query_json = <<-EOT
{
    "time_range": 600,
    "granularity": 0,
    "breakdowns": [
        "k8s.namespace.name",
        "k8s.container.name"
    ],
    "calculations": [
        {
            "op": "COUNT"
        }
    ],
    "filters": [
        {
            "column": "status.ready",
            "op": "=",
            "value": false
        }
    ],
    "filter_combination": "AND",
    "orders": [
        {
            "op": "COUNT",
            "order": "descending"
        }
    ],
    "havings": []
}
  EOT
}

resource "honeycombio_trigger" "failedreadiness" {
  name        = "Pods are not passing readiness check"
  description = "Pods on the cluster are not ready"

  query_id = honeycombio_query.failedreadiness.id
  dataset  = var.dataset

  frequency = 180 // in seconds, ~3 minutes

  alert_type = "on_change" // on_change is default, on_true can refers to the "Alert on True" checkbox in the UI

  threshold {
    op    = ">"
    value = 5
  }

  # zero or more recipients
  recipient {
    type   = "slack"
    target = "#test-alert"
  }

  recipient {
    type   = "marker"
    target = "Trigger - Failing Readiness Check"
  }
}
