
variable "TAG" {
  default = "latest"
}

#***********************************************
# Verdaccio Plugins
#***********************************************

target "plugins-prometheus" {
  args = {}
  context = "."
  dockerfile = "Dockerfile.prometheus"
  labels = {
    "org.opencontainers.image.title"= "Dockerfile.prometheus:${TAG}"
  }
  tags = ["verdaccio.prometheus:${TAG}"]
}


group "default" {
  targets = [
    "plugins-prometheus", 
    ]
}
