# README.md
Demonstrates how to deploy a simple hello world pod 

Documentation for the pods resources
[docs](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#pod-v1-core)

```sh
kubectl explain pods   
```

## Deploy imperative

```sh
# kickstart an ubuntu pod
kubectl run testubuntu --image=ubuntu:18.04 -n default --limits="cpu=200m,memory=512Mi" --restart=Never -- /bin/sh -c "sleep 10000"

# shell into it
kubectl exec -it testubuntu -- /bin/sh

# install some tools
apt update
apt install curl dnsutils iputils-ping telnet

# tidy up
kubectl delete pod testubuntu
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

