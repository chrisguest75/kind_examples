# README

Demonstrates how to use helm3 to create and deploy a simple deployment.  

## Prerequisites

```sh
brew install helm
```

## Create

Create a template hello-world application.  

```sh
helm create hello-world  
```

## Install

```sh
# install hello-world
helm install hello-world ./hello-world

# installing into a namespace
helm upgrade --install hello-world ./hello-world --namespace hello-world --create-namespace

# see the pods 
kubectl get pods --all-namespaces

# list releases
helm list --namespace hello-world

# check deployment status
helm status hello-world --namespace hello-world
```

## Upgrade

```sh
# modify the replicas in values.yaml 
cat ./hello-world/values.yaml

# upgrade
helm upgrade hello-world ./hello-world --namespace hello-world

# see the pods 
kubectl get pods --all-namespaces
```

## Rollback

```sh
# show history
helm history hello-world --namespace hello-world

# rollback to previous version
helm rollback hello-world --namespace hello-world

# history is added to
helm history hello-world --namespace hello-world
```

## Troubleshooting

Extract the values from a deployment.  

```sh
# pull the values.yaml back from a revision
helm get values hello-world --namespace hello-world --revision 2 -a
```

## Remove

```sh
# uninstall the chart
helm uninstall hello-world --namespace hello-world
```

## Resources

* Helm [here](https://helm.sh/)  
