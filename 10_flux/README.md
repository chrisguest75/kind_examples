# FLUX

Demonstrate how to get flux running on a cluster  

## Create

```sh
kind create cluster --name fluxkind --wait 1m  
```

## Prerequisites

```sh
brew install fluxcd/tap/flux

flux --help

# Check prerequisites
flux check --pre
```

## Install

```sh
# Install the latest version of Flux
flux install
```

## Deploy

```sh
# Create a source for a public Git repository
flux create source git webapp-latest \
    --url=https://github.com/stefanprodan/podinfo \
    --branch=master \
    --interval=3m

# List GitRepository sources and their status
flux get sources git

# Trigger a GitRepository source reconciliation
flux reconcile source git flux-system

# Export GitRepository sources in YAML format
flux export source git --all > sources.yaml

# Create a Kustomization for deploying a series of microservices
flux create kustomization webapp-dev \
--source=webapp-latest \
--path="./deploy/webapp/" \
--prune=true \
--interval=5m \
--health-check="Deployment/backend.webapp" \
--health-check="Deployment/frontend.webapp" \
--health-check-timeout=2m

# Trigger a git sync of the Kustomization's source and apply changes
flux reconcile kustomization webapp-dev --with-source
```

## Test

```sh
# port forwarding
kubectl get pods -n webapp backend-7bbcb4f675-wf94j -o yaml  
kubectl get pods -n webapp frontend-6bcfd55d7d-2d8wq -o yaml  
kubectl --namespace webapp port-forward frontend-6bcfd55d7d-2d8wq 9898
```

## Cleanup

```sh
# Suspend a Kustomization reconciliation
flux suspend kustomization webapp-dev

# Export Kustomizations in YAML format
flux export kustomization --all > kustomizations.yaml

# Resume a Kustomization reconciliation
flux resume kustomization webapp-dev

# Delete a Kustomization
flux delete kustomization webapp-dev
kubectl get pods --all-namespaces

# Delete a GitRepository source
flux delete source git webapp-latest

# Uninstall Flux and delete CRDs
flux uninstall
```

## Resources

* Get Started with Flux [here](https://fluxcd.io/flux/get-started/)
* fluxcd/flux2 [here](https://github.com/fluxcd/flux2)
* This guide walks you through setting up Flux to manage one or more Kubernetes clusters. [here](https://fluxcd.io/flux/installation/)  
* stefanprodan/podinfo repo [here](https://github.com/stefanprodan/podinfo)  
