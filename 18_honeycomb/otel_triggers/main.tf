terraform {
  required_version = "~>1.3.2"

  required_providers {
    honeycombio = {
      source  = "honeycombio/honeycombio"
      version = "0.15.1"
    }
  }

  backend "local" {
    path = "./state/terraform.tfstate"
  }
}

variable "dataset" {
  type = string
}

# data "honeycombio_query_specification" "example" {
#   calculation {
#     op     = "AVG"
#     column = "duration_ms"
#   }

#   filter {
#     column = "trace.parent_id"
#     op     = "does-not-exist"
#   }

#   time_range = 1800
# }
