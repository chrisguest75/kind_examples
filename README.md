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
* Skaffold
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

## 01_Creation
Demonstrates how to build a cluster using kind   
[README.md](01_creation/README.md)

## 03_Deploy_Pod
Demonstrates how to deploy a simple hello world pod  
[README.md](03_deploy_pod/README.md)

## 04_deployments
Demonstrates how to deploy a simple hello world deployment  
[README.md](04_deployments/README.md)

## 05_simple_helm3
Demonstrates how to use helm3 to create and deploy a simple deployment.  
[README.md](05_simple_helm3/README.md)

## 06_volumes
Demonstrate how to share a local volume into a container on Kind    
[README.md](06_volumes/README.md)

## 07_localimages
Demonstrates how to deploy a simple pod from a local image  
[README.md](07_localimages/README.md)

## 08_skaffold
Demonstrates how to configure skaffold to work with kind  
[README.md](08_skaffold/README.md)
