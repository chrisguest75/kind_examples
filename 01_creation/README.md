# 00_create_cluster

Demonstrates how to build a cluster using Kind  

From [kind_examples](https://github.com/chrisguest75/kind_examples)

- [00\_create\_cluster](#00_create_cluster)
  - [Tooling](#tooling)
  - [Install microk8s](#install-microk8s)
  - [Install Kind Simple Example](#install-kind-simple-example)
    - [Examine the cluster](#examine-the-cluster)
    - [Remove Cluster](#remove-cluster)
  - [Build from manifest (declarative)](#build-from-manifest-declarative)
  - [Enable ephermeral containers](#enable-ephermeral-containers)
  - [Using different versions of Kubenetes](#using-different-versions-of-kubenetes)
  - [Resources](#resources)

## Tooling

krew [Install](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)

```sh
# install kubectx and kubens
kubectl krew install ctx 
kubectl krew install ns

kubectl ctx
kubectl ns
```

## Install microk8s

Install [microk8s](https://microk8s.io/docs)  

```sh
# configure context
microk8s config > ~/.kube/config 
```

## Install Kind Simple Example

Check out ["Using different versions of Kubenetes"](#using-different-versions-of-kubenetes) for specific versions.  

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

# show the versions of the apis.
kubectl api-versions        
```

### Remove Cluster

```sh
kind delete cluster --name mykind 
```

## Build from manifest (declarative)

1 node cluster.  

```sh
kind create cluster --config 1node_cluster.yaml --name mykind
```

3 node cluster.  

```sh
kind create cluster --config 3node_cluster.yaml --name mykind
```

## Enable ephermeral containers

Ephermeral containers allow installation of debugging side-cars on Kubenetes.  

```sh
kind create cluster --config featuregate_cluster.yaml --name mykind
```

## Using different versions of Kubenetes

Goto RELEASES [here](https://github.com/kubernetes-sigs/kind/releases)  

NOTE: The images are aligned to the version of `Kind` so check releases page for notes on images.  

For v0.20 of `Kind` the following images can be used.  

|Version  | Id  |
|---------|---------|
|1.27     | kindest/node:v1.27.3@sha256:3966ac761ae0136263ffdb6cfd4db23ef8a83cba8a463690e98317add2c9ba72        |
|1.26     | kindest/node:v1.26.6@sha256:6e2d8b28a5b601defe327b98bd1c2d1930b49e5d8c512e1895099e4504007adb        |
|1.25     | kindest/node:v1.25.11@sha256:227fa11ce74ea76a0474eeefb84cb75d8dad1b08638371ecf0e86259b35be0c8       |
|1.24     | kindest/node:v1.24.15@sha256:7db4f8bea3e14b82d12e044e25e34bd53754b7f2b0e9d56df21774e6f66a70ab        |
|1.23     | kindest/node:v1.23.17@sha256:59c989ff8a517a93127d4a536e7014d28e235fb3529d9fba91b3951d461edfdb        |
|1.22     | kindest/node:v1.22.17@sha256:f5b2e5698c6c9d6d0adc419c0deae21a425c07d81bbf3b6a6834042f25d4fba2        |
|1.21     | kindest/node:v1.21.14@sha256:8a4e9bb3f415d2bb81629ce33ef9c76ba514c14d707f9797a01e3216376ba093        |

Create the cluster  

```sh
kind create cluster --name mykind --wait 1m --image kindest/node:v1.21.14@sha256:8a4e9bb3f415d2bb81629ce33ef9c76ba514c14d707f9797a01e3216376ba093

kubectl api-versions
```

Show API versions  

```txt
admissionregistration.k8s.io/v1
admissionregistration.k8s.io/v1beta1
apiextensions.k8s.io/v1
apiextensions.k8s.io/v1beta1
apiregistration.k8s.io/v1
apiregistration.k8s.io/v1beta1
apps/v1
authentication.k8s.io/v1
authentication.k8s.io/v1beta1
authorization.k8s.io/v1
authorization.k8s.io/v1beta1
autoscaling/v1
autoscaling/v2beta1
autoscaling/v2beta2
batch/v1
batch/v1beta1
certificates.k8s.io/v1
certificates.k8s.io/v1beta1
coordination.k8s.io/v1
coordination.k8s.io/v1beta1
discovery.k8s.io/v1
discovery.k8s.io/v1beta1
events.k8s.io/v1
events.k8s.io/v1beta1
extensions/v1beta1
flowcontrol.apiserver.k8s.io/v1beta1
networking.k8s.io/v1
networking.k8s.io/v1beta1
node.k8s.io/v1
node.k8s.io/v1beta1
policy/v1
policy/v1beta1
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
scheduling.k8s.io/v1
scheduling.k8s.io/v1beta1
storage.k8s.io/v1
storage.k8s.io/v1beta1
v1
```

Create the cluster  

```sh
kind create cluster --name mykind --wait 1m --image kindest/node:v1.23.17@sha256:59c989ff8a517a93127d4a536e7014d28e235fb3529d9fba91b3951d461edfdb

kubectl api-versions
```

Show API versions  

```txt
admissionregistration.k8s.io/v1
apiextensions.k8s.io/v1
apiregistration.k8s.io/v1
apps/v1
authentication.k8s.io/v1
authorization.k8s.io/v1
autoscaling/v1
autoscaling/v2
autoscaling/v2beta1
autoscaling/v2beta2
batch/v1
batch/v1beta1
certificates.k8s.io/v1
coordination.k8s.io/v1
discovery.k8s.io/v1
discovery.k8s.io/v1beta1
events.k8s.io/v1
events.k8s.io/v1beta1
flowcontrol.apiserver.k8s.io/v1beta1
flowcontrol.apiserver.k8s.io/v1beta2
networking.k8s.io/v1
node.k8s.io/v1
node.k8s.io/v1beta1
policy/v1
policy/v1beta1
rbac.authorization.k8s.io/v1
scheduling.k8s.io/v1
storage.k8s.io/v1
storage.k8s.io/v1beta1
v1
```

## Resources  

* Kubernetes Ephemeral Containers and kubectl debug Command [here](https://iximiuz.com/en/posts/kubernetes-ephemeral-containers/)  
