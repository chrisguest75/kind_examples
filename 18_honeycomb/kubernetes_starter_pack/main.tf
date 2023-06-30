terraform {
  required_version = "~>1.3.2"

  backend "local" {
    path = "./state/terraform.tfstate"
  }
}

module "explore-honeycombio-kubernetes-starter-pack" {
  source = "honeycombio/kubernetes-starter-pack/honeycombio"
}
