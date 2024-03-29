# README

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)  

A repo for examples of Kubernetes features using Kind as a cluster  
[KIND Docs](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Contents

- [README](#readme)
  - [Contents](#contents)
  - [Conventional Commits](#conventional-commits)
  - [Installation](#installation)
  - [Tools](#tools)
  - [Describing Resources](#describing-resources)
  - [Actions](#actions)
  - [01 Creation](#01-creation)
  - [03 deploy pods](#03-deploy-pods)
  - [04 deployments](#04-deployments)
  - [05 simple helm3](#05-simple-helm3)
  - [06 volumes](#06-volumes)
  - [07 localimages](#07-localimages)
  - [08 skaffold](#08-skaffold)
  - [09 hpa](#09-hpa)
  - [10 fluxv2](#10-fluxv2)
  - [11 ingress](#11-ingress)
  - [12 session affinity](#12-session-affinity)
  - [13 kubernetes dashboard](#13-kubernetes-dashboard)
  - [15 upgrades](#15-upgrades)
  - [16 sealed secrets](#16-sealed-secrets)
  - [17 podinfo](#17-podinfo)
  - [18 honeycomb](#18-honeycomb)
  - [19 authoring helm charts](#19-authoring-helm-charts)

## Conventional Commits

NOTE: This repo has switched to [conventional commits](https://www.conventionalcommits.org/en/v1.0.0). It requires `pre-commit` and `commitizen` to help with controlling this.  

```sh
# install pre-commmit (prerequisite for commitizen)
brew install pre-commit
brew install commitizen
# conventional commits extension
code --install-extension vivaxy.vscode-conventional-commits

# install hooks
pre-commit install --hook-type commit-msg --hook-type pre-push
```

## Installation

```sh
kind version
# last worked on
kind v0.20.0 go1.20.5 darwin/amd64

brew install kind
```

## Tools

kubectx and kubens - [https://github.com/ahmetb/kubectx](https://github.com/ahmetb/kubectx)

```sh
brew install kubectx
brew install kubens
```

## Describing Resources

```sh
kubectl explain deployment.spec.template.spec.containers
```

## Actions

Demonstrate using kind cluster in ci pipeline.  
[README.md](.github/WORKFLOWS.md)  

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

## 07 localimages

Demonstrates how to deploy a simple pod from a local image  
[README.md](07_localimages/README.md)  

## 08 skaffold

Demonstrates how to configure skaffold to work with kind  
[README.md](08_skaffold/README.md)  

## 09 hpa

Demonstrate how to use the HPA for scaling.  
[README.md](09_hpa/README.md)  

## 10 fluxv2

Demonstrate how to get `FluxV2` running on a cluster  
[README.md](10_flux_v2/README.md)  

## 11 ingress

Demonstrates how to install an ingress controller on kind  
[README.md](11_ingress/README.md)  

## 12 session affinity

Create an example that uses the official `ingress-nginx` with session affinity  
[README.md](12_session_affinity/README.md)  

## 13 kubernetes dashboard

Kubernetes Dashboard is a general purpose, web-based UI for Kubernetes clusters. It allows users to manage applications running in the cluster and troubleshoot them, as well as manage the cluster itself.  
[README.md](13_dashboard/README.md)  

## 15 upgrades

Demonstrate Kubernetes upgrades wih examples.  
[README.md](15_upgrades/README.md)  

## 16 sealed secrets

Sealed Secrets are "one-way" encrypted K8s Secrets that can be created by anyone, but can only be decrypted by the controller running in the target cluster recovering the original object.  
[README.md](16_sealed_secrets/README.md)  

## 17 podinfo

Podinfo Helm chart for Kubernetes.  
[README.md](17_podinfo/README.md)  

## 18 honeycomb

Honeycomb Kubernetes Agent  
[README.md](18_honeycomb/README.md)  

## 19 authoring helm charts

Authoring HELM charts.  
[README.md](19_author_helm_charts/README.md)  
