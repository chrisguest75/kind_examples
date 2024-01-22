# FLUXV2

Demonstrate how to get `FluxV2` running on a cluster  

TODO:
 
* What is the kustomize path?
* bootstrap with terraform https://fluxcd.io/flux/installation/#bootstrap-with-terraform
* gh cli personal access token?

## Terminology

* gotk - GitOps Toolkit

## Notes

* You store references to repos in the deployment repo.
* You can push to OCI artifacts instead of a git repository. This means you only need one credential on the cluster.  
* The resync time is controlled by the `--interval` when creating the resource.  

## Contents

- [FLUXV2](#fluxv2)
  - [Terminology](#terminology)
  - [Notes](#notes)
  - [Contents](#contents)
  - [Clusters](#clusters)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Deploy](#deploy)
  - [Test](#test)
  - [Modification](#modification)
  - [Manage](#manage)
  - [Remove Cluster](#remove-cluster)
  - [Resources](#resources)

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_27_cluster.yaml --name kind-1-27
```

## Prerequisites

Install and check prerequisites.  

```sh
brew install fluxcd/tap/flux

flux --help

# Check prerequisites
flux check --pre
```

## Install

```sh
# check your connection
kubectx

# source GITHUB_TOKEN
# NOTE: When creating the token Github settings -> "Developer Settings" tokens classic and just give access to "repos" only.  
. ./.env

# bootstrap the cluster
flux bootstrap github \
  --token-auth \
  --owner=${GITHUB_USER} \
  --repository=fluxv2_deployment_test \
  --branch=main \
  --path=clusters/kind-kind-1-27 \
  --personal

# open k9s
k9s
```

## Deploy

```sh
# sync repo locally.
git clone git@github.com:chrisguest75/fluxv2_deployment_test.git
```

NOTE: This must all be done in the `fluxv2_deployment_test` repo

```sh
# Create a source for a public Git repository
flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=1m \
  --export > ./clusters/kind-kind-1-27/podinfo-source.yaml

# commit and sync
git add -A && git commit -m "Add podinfo GitRepository"
git push

# List GitRepository sources and their status
flux get sources git

# Trigger a GitRepository source reconciliation
flux reconcile source git flux-system

# Export GitRepository sources in YAML format
mkdir -p ./out
flux export source git --all > ./out/sources.yaml

# Create a Kustomization for deploying a series of microservices
flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --wait=true \
  --interval=30m \
  --retry-interval=2m \
  --health-check-timeout=3m \
  --export > ./clusters/kind-kind-1-27/podinfo-kustomization.yaml

git add -A && git commit -m "Add podinfo Kustomization"
git push

# Trigger a git sync of the Kustomization's source and apply changes
flux reconcile kustomization podinfo --with-source
```

## Test

```sh
# port forwarding  
kubectl --namespace default port-forward $(kubectl get pods --no-headers --all-namespaces --selector=app=podinfo -o custom-columns=NAME:.metadata.name | head -n 1) 9898
```

## Modification

* Patching kustomize `podinfo-kustomization.yaml`

```yaml
spec:
  patches:
    - patch: |-
        apiVersion: autoscaling/v2
        kind: HorizontalPodAutoscaler
        metadata:
          name: podinfo
        spec:
          minReplicas: 3             
      target:
        name: podinfo
        kind: HorizontalPodAutoscaler
```

## Manage

```sh
# Suspend a Kustomization reconciliation
flux suspend kustomization podinfo

# Export Kustomizations in YAML format
flux export kustomization --all 

# Resume a Kustomization reconciliation
flux resume kustomization podinfo

# Delete a Kustomization (this will delete until the repos resyncs based on --interval)
flux delete kustomization podinfo
kubectl get pods --all-namespaces

# Delete a GitRepository source
flux delete source git podinfo
```

## Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name kind-1-27

kubectx -d kind-1-27
```

## Resources

* Get Started with Flux [here](https://fluxcd.io/flux/get-started/)
* fluxcd/flux2 [here](https://github.com/fluxcd/flux2)
* This guide walks you through setting up Flux to manage one or more Kubernetes clusters. [here](https://fluxcd.io/flux/installation/)  
* stefanprodan/podinfo repo [here](https://github.com/stefanprodan/podinfo)  
* What is GitOps? [here](https://www.gitops.tech/#what-is-gitops)  
* Personal Access Tokens [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)  
