# README.md
Demonstrates how to deploy a simple hello world pod 

Documentation for the pods resources
```sh
kubectl explain pods   
```

## Creation
```sh
# Create a pod
kubectl create -f ./pod.yaml
# View pods
kubectl get pods 
# Get the logs for the pod
kubectl logs myapp-pod    
```

## Removal
```sh
kubectl delete pods myapp-pod
```
