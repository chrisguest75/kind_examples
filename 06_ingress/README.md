# README
Demonstrates how to build a cluster using Kind 

## Build cluster

```sh
kind create cluster --config ingress_cluster.yaml --name myingress
kubectl cluster-info --context kind-myingress
kubectl apply -f ./ingress.yaml 
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


