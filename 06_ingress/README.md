# README
Demonstrates how to build a cluster using Kind 

Based on [ingress](https://kind.sigs.k8s.io/docs/user/ingress/)
## Build cluster

```sh
# create the cluster
kind create cluster --config ingress_cluster.yaml --name myingress

# show cluster details
kubectl cluster-info --context kind-myingress

# show cluster info dump
kubectl cluster-info dump       
```


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

kubectl apply -f ./ingress.yaml 
```

## Test ingress
```sh
# should output "foo"
curl localhost/foo
# should output "bar"
curl localhost/bar

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
```


