# README.md

Demonstrates how to deploy a simple pod from a local image  

## Build and Test Locally

Build and test the image  

```sh
docker build -t localtest .        
docker run -it --rm --name localtest localtest 

# stop it
docker stop localtest
```

```sh
# load image
kind load docker-image --name mykind localtest:latest      
```

## Deploy imperative

```sh
# kickstart an ubuntu pod
kubectl run localtest --image=docker.io/library/localtest:latest  -n default --limits="cpu=200m,memory=512Mi" --restart=Never 

# shell into it
kubectl logs localtest

# tidy up
kubectl delete pod localtest

# list all pods
kubectl get pods --all-namespaces 
```

## Troubleshooting images

```sh
# look at pod events.
kubectl describe pod localtest

# list nodes
kubectl get nodes     

# exec into the node
docker exec -it mykind-control-plane bash 

# list images loaded
crictl images
```
