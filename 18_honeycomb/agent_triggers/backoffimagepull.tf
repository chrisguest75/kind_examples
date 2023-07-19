
resource "honeycombio_query" "backoffpullingimage" {
  dataset    = var.eventsdataset
  query_json = <<-EOT
{
    "time_range": 900,
    "granularity": 0,
    "breakdowns": [],
    "calculations": [
        {
            "op": "COUNT"
        }
    ],
    "filters": [
        {
            "column": "message",
            "op": "contains",
            "value": "Back-off pulling image"
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

resource "honeycombio_trigger" "backoffpullingimage" {
  name        = "Pods are backing off pulling images"
  description = "Back-off pulling image"

  query_id = honeycombio_query.backoffpullingimage.id
  dataset  = var.eventsdataset

  frequency = 240 // in seconds, 4 minutes

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
    target = "Trigger - Back-off pulling image"
  }
}
