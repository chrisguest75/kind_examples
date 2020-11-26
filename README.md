# README

A repo for examples of Kubernetes features using Kind as a cluster  
[KIND Docs](https://kind.sigs.k8s.io/docs/user/quick-start/)

## TODO

* Helm3
* Add a queue simple service and chart
* Kustomize example.
* Local docker desktop registry access
* Build clusters
* Publishing images
* Services
* Sidecar
* Stateful set
* Create a CRD
* Metrics export
* Namespaces and RBAC
* Fluentd
* Open census

## Installation

```sh
kind version
kind v0.7.0 go1.12.5 darwin/amd64
```

## Tools

kubectx and kubens - [https://github.com/ahmetb/kubectx](https://github.com/ahmetb/kubectx)

## Describing Resources

```sh
kubectl explain deployment.spec.template.spec.containers
```

## 01 Creation

Demonstrates how to build a cluster using kind  
[README.md](01_creation/README.md)

## 03 deploy pods

Demonstrates how to deploy a simple hello world pod  
[README.md](03_deploy_pod/README.md)

## 04 deployments

Demonstrates how to deploy a simple hello world deployment  
[README.md](04_deployments/README.md)

## 05 simple helm3

Demonstrates how to use helm3 to create and deploy a simple deployment.  
[README.md](05_simple_helm3/README.md)

## 06 volumes

Demonstrate how to share a local volume into a container on Kind  
[README.md](06_volumes/README.md)

## 06 ingress

Demonstrates how to install an ingress controller on kind  
[README.md](06_ingress/README.md)

## 07 localimages

Demonstrates how to deploy a simple pod from a local image  
[README.md](07_localimages/README.md)

## 08 skaffold

Demonstrates how to configure skaffold to work with kind  
[README.md](08_skaffold/README.md)

## 09 hpa

Demonstrate how to use the HPA for scaling.  
[README.md](09_hpa/README.md)

## 10 flux

Demonstrate how to get flux running on a cluster  
[README.md](10_flux/README.md)