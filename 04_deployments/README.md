# README
Demonstrates how to deploy a simple hello world deployment

Documentation for the deployments resources [docs](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#deployment-v1-apps)
```sh
kubectl explain deployments  
```

## Creation
```sh
# Create a deployment
kubectl create -f ./deployment.yaml
# View pods
kubectl get deployments 
kubectl get pods
kubectl port-forward deployment-example-6c748d4965-kh4jp 8080:80
open http://localhost:8080/
```

## Removal
```sh
kubectl delete deployments deployment-example
```