# README

Demonstrates how to use helm3 to create and deploy a simple deployment.  

TODO:

* Deploy to another namespace

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

# see the pods 
kubectl get pods

# list releases
helm list

# check deployment status
helm status hello-world
```

## Upgrade

```sh
# modify the replicas in values.yaml 
cat ./hello-world/values.yaml

# upgrade
helm upgrade hello-world ./hello-world

# see the pods 
kubectl get pods
```

## Rollback

```sh
# show history
helm history hello-world

# rollback to previous version
helm rollback hello-world

# history is added to
helm history hello-world
```

## Troubleshooting

```sh
# pull the values.yaml back from a revision
helm get values hello-world --revision 2 -a
```

## Remove

```sh
# uninstall the chart
helm uninstall hello-world
```

## Resources

* Helm [here](https://helm.sh/)  
