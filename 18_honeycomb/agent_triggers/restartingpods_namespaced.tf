
resource "honeycombio_query" "restartingpods_namespaced" {
  dataset    = var.dataset
  query_json = <<-EOT
{
    "time_range": 600,
    "granularity": 0,
    "breakdowns": [
        "k8s.namespace.name"
    ],
    "calculations": [
        {
            "op": "SUM",
            "column": "status.restart_delta"
        }
    ],
    "orders": [
        {
            "column": "status.restart_delta",
            "op": "SUM",
            "order": "descending"
        }
    ],
    "havings": [
    ]
}
  EOT
}

resource "honeycombio_trigger" "restartingpods_namespaced" {
  name        = "Pods are restarting too often (namespaced). (honeycomb-agent) "
  description = "Pods on the cluster are restarting too often (namespaced). Honeycomb Agent based."

  query_id = honeycombio_query.restartingpods_namespaced.id
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
    target = "Trigger - Too many restarts detected (namespaced)"
  }
}
