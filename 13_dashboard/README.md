# INSTALL DASHBOARD

TODO:

* The metrics scraper does not seem to work

## Build cluster

```sh
# create the cluster
# the user token technique doesn't seem to work on 1.27
kind create cluster --config dashboard_cluster.yaml --name mydashboard --image kindest/node:v1.21.14@sha256:8a4e9bb3f415d2bb81629ce33ef9c76ba514c14d707f9797a01e3216376ba093

kubectx

# show cluster details
kubectl cluster-info --context kind-mydashboard

# show cluster info dump
kubectl cluster-info dump
```

## Pull

```sh
# add repo
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm search repo kubernetes-dashboard
# find versions of a chart 
helm search repo kubernetes-dashboard --versions

# pull chart
mkdir -p ./charts
export CHART_VERSION=6.0.8 
helm pull kubernetes-dashboard/kubernetes-dashboard --version ${CHART_VERSION} --untar --untardir ./charts/kubernetes-dashboard-${CHART_VERSION}
```

## Install

```sh
kubectl apply -f ./kubernetes-dashboard-user.yaml

helm upgrade --install kubernetes-dashboard kubernetes-dashboard --repo https://kubernetes.github.io/dashboard --namespace kubernetes-dashboard -f ./kubernetes-dashboard-values.yaml --create-namespace

kubectl get pods --all-namespaces 
```

## Connect

```sh
# NEW
kubectl -n kubernetes-dashboard get service kubernetes-dashboard -o yaml   
kubectl port-forward --namespace=kubernetes-dashboard svc/kubernetes-dashboard 8443:443

# get token
kubectl -n kubernetes-dashboard get secrets 
kubectl -n kubernetes-dashboard describe secret dashboard-user-token-r6mm6  
open https://localhost:8443
```

### Remove Cluster

```sh
kind delete cluster --name mykind-dashboard

kubectx -d kind-mydashboard  
```

## Resources

* Accessing Dashboard [here](https://github.com/kubernetes/dashboard/blob/master/docs/user/accessing-dashboard/README.md)  
* Kubernetes Dashboard - Internal error (500): Not enough data to create auth info structure [here](https://stackoverflow.com/questions/70287656/kubernetes-dashboard-internal-error-500-not-enough-data-to-create-auth-info)  
* Creating admin user to access Kubernetes dashboard [here](https://medium.com/@kanrangsan/creating-admin-user-to-access-kubernetes-dashboard-723d6c9764e4)

