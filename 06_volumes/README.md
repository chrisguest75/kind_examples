# README
Demonstrate how to share a local volume into a container on Kind

## Build from manifest (declarative)
```sh
# build a cluster mapping folder into kind
kind create cluster --config 1node_cluster.yaml --name mykind
```

```sh
# create volume
kubectl create -f ./volumes.yaml   
# create pod
kubectl create -f ./pod.yaml  

# show the pod
kubectl get pod --all-namespaces  

# shell into container
kubectl exec -ti myapp-pod -- sh   

# show contents of the volume (local edits can be seen)
ls -a /var/test-volume/
```
### Remove Cluster
```sh
kind delete cluster --name mykind 
```

# Resources
* Mounts [here](https://kind.sigs.k8s.io/docs/user/configuration/#extra-mounts)
* Stackoverflow example [here](https://stackoverflow.com/questions/62694361/how-to-reference-a-local-volume-in-kind-kubernetes-in-docker)

