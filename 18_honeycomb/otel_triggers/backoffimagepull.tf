
resource "honeycombio_query" "backoffpullingimage" {
  dataset    = var.dataset
  query_json = <<-EOT
{
    "time_range": 1800,
    "granularity": 0,
    "calculations": [
        {
            "op": "COUNT"
        }
    ],
    "filters": [
        {
            "column": "event.name",
            "op": "exists"
        },
        {
            "column": "body",
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
    ]
}
  EOT
}

resource "honeycombio_trigger" "backoffpullingimage" {
  name        = "Test honeycombio_trigger in terraform"
  description = "Back-off pulling image"

  query_id = honeycombio_query.backoffpullingimage.id
  dataset  = var.dataset

  frequency = 600 // in seconds, 10 minutes

  alert_type = "on_true" // on_change is default, on_true can refers to the "Alert on True" checkbox in the UI

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
    target = "Trigger - Back-off pulling image"
  }
}
