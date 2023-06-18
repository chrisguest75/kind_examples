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

mkdir -p ./charts
export CHART_VERSION=3.31.0
export CHART_VERSION=4.0.1
export CHART_VERSION=4.7.0
helm pull ingress-nginx/ingress-nginx --version ${CHART_VERSION} --untar --untardir ./charts/ingress-nginx-${CHART_VERSION}

# extract values (this has to be an actual deployment on the cluster)
# the version of the values will be for the chart version installed
helm get values my-ingress-nginx --namespace kube-system --all > ./charts/ingress-nginx-${CHART_VERSION}/actual-values.yaml 

# compare folders
bcompare ingress-nginx-3.31.0 ingress-nginx-4.0.1   

# export a rendered template for the chart
# copy the actual-values.yaml from the installed chart
helm template my-ingress-nginx ./charts/ingress-nginx-${CHART_VERSION}/ingress-nginx -f ./charts/ingress-nginx-${CHART_VERSION}/actual-values.yaml --namespace default > ./charts/ingress-nginx-${CHART_VERSION}.yaml
```

## Resources

* Helm [here](https://helm.sh/)  
