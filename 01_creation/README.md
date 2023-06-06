# README

Demonstrates how to build a cluster using Kind

## Simple Example

```sh
# Create the cluster
kind create cluster --name mykind --wait 1m  

Creating cluster "mykind" ...
 ✓ Ensuring node image (kindest/node:v1.17.0) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Waiting ≤ 1m0s for control-plane = Ready ⏳
 • Ready after 57s 💚
Set kubectl context to "kind-mykind"
You can now use your cluster with:

# You should have a new context
kubectx

# The default namespaces should exist
kubens

# list clusters
kind get clusters 

# list nodes
kind get nodes --name mykind 

# Ensure everything is running
kubectl cluster-info --context kind-mykind
```

### Examine the cluster

```sh
# Look at running pods
kubectl get pods --all-namespaces

# Show the installed resources
kubectl api-resources
```

### Remove Cluster

```sh
kind delete cluster --name mykind 
```

## Build from manifest (declarative)

```sh
kind create cluster --config 1node_cluster.yaml --name mykind
```

```sh
kind create cluster --config 3node_cluster.yaml --name mykind
```

## Enable ephermeral containers

```sh
kind create cluster --config featuregate_cluster.yaml --name mykind
```
