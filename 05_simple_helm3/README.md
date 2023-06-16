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

## Remove

```sh
# uninstall the chart
helm uninstall hello-world --namespace hello-world
```

## Troubleshooting

Extract the values from a deployment.  

```sh
# pull the values.yaml back from a revision
helm get values hello-world --namespace hello-world --revision 2 -a
```

Diffing two rendered charts.  

```sh
# show charts
helm list --namespace kube-system
# show histroy
helm history my-ingress-nginx --namespace kube-system

# pull the chart versions locally
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm pull ingress-nginx/ingress-nginx --version 3.31.0 --untar
helm pull ingress-nginx/ingress-nginx --version 4.0.1 --untar

# extract values 
helm get values my-ingress-nginx --namespace kube-system --all >  ./ingress-nginx-3.31.0/actual-values.yaml 

# compoare
bcompare ingress-nginx-3.31.0 ingress-nginx-4.0.1   

# export a rendered template for th chart
helm template my-ingress-nginx ./ingress-nginx-4.0.1 -f ./ingress-nginx-4.0.1/actual-values.yaml --namespace default > ingress-nginx-4.0.1.yaml
helm template my-ingress-nginx ./ingress-nginx-3.31.0 -f ./ingress-nginx-3.31.0/actual-values.yaml --namespace default > ingress-nginx-3.31.0.yaml
```

## Resources

* Helm [here](https://helm.sh/)  
