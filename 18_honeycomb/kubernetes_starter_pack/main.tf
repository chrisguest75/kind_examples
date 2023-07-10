terraform {
  required_version = "~>1.3.2"

  backend "local" {
    path = "./state/terraform.tfstate"
  }
}

variable "dataset_name" {
  type = string
}

module "explore-honeycombio-kubernetes-starter-pack" {
  source = "honeycombio/kubernetes-starter-pack/honeycombio"

  dataset_name = var.dataset_name
}
