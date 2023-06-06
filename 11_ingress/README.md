# README

Demonstrates how to use ingress on Kind.  

Based on [ingress](https://kind.sigs.k8s.io/docs/user/ingress/)  

## Build cluster

```sh
# create the cluster
kind create cluster --config ingress_cluster.yaml --name myingress

kubectx

# show cluster details
kubectl cluster-info --context kind-myingress

# show cluster info dump
kubectl cluster-info dump
```

## Install ingress

```sh
# install the ingress
kubectl apply -f ./ingress_nginx_patch.yaml

# wait for it to become ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

```sh
# create 1 or the other
kubectl apply -f ./ingress-agnhost.yaml 
kubectl apply -f ./ingress-http-echo..yaml

# once tested you can remove either of them
kubectl delete -f ./ingress-agnhost.yaml 
kubectl delete -f ./ingress-http-echo..yaml
```

## Test ingress

```sh
# should output "foo"
curl http://127.0.0.1:8080/foo
# should output "bar"
curl http://127.0.0.1:8080/bar
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
kind delete cluster --name myingress 
kubectx
```

## Resoures

* Setting Up An Ingress Controller [here](https://kind.sigs.k8s.io/docs/user/ingress)  
