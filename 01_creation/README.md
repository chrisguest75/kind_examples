# README
Demonstrates how to build a cluster using kind

## Example
Create it 
```sh
> kind create cluster --name mykind --wait 1m  
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

kubectl cluster-info --context kind-mykind
```

## Examine the cluster

```sh
# Look at running pods
kubectl get pods --all-namespaces

# Show the installed resources
kubectl api-resources
```

## Remove Cluster
```sh
kind delete cluster --name mykind 
```