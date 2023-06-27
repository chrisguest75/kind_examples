# UPGRADES

Demonstrate upgrades wih examples.  

TODO:

* List them out and use kubepug to hightlight them.  

## 1.21 cluster

Create a 1.21 single node cluster.  

```sh
kind create cluster --config 1node_1_21_cluster.yaml --name kind-1-21

kubectl api-versions

# create the namespace 
kubectl create -f ./1.21/namespace.yaml
kubectl create -f ./1.21/roles.yaml
kubectl create -f ./1.21/bindings.yaml
# run a pod 
kubectl create -f ./1.21/pod.yaml -n versions-test

kubectl get all -n versions-test
# it looks like it upgrades the apis on install
kubectl get Role,RoleBindings -n versions-test -o yaml | yq .
```

## List resources on cluster

```sh
mkdir -p ./out
# 
kubectl get --all-namespaces $(kubectl api-resources --no-headers | awk '{print $1}' | tr '\n' ',' | sed s/,\$//) -o json | jq -c '.items[] | [.apiVersion, .metadata.name, .metadata.namespace]' > ./out/1-21-manifest.json
```

## Kubepug

```sh
mkdir -p ./kubepug

# GET DOWNLOAD COMMAND

./kubepug/kubepug
./kubepug/kubepug --context arn:aws:eks:us-east-1:378239092462:cluster/dev --k8s-version=v1.22.17 --api-walk
```

## 1.22 cluster

Create a 1.22 single node cluster.  

```sh
kind create cluster --config 1node_1_22_cluster.yaml --name kind-1-22

kubectl api-versions
# try the old v1beta1 apis. 

# create the namespace 
kubectl create -f ./1.21/namespace.yaml
# THIS WILL FAIL AS API IS NOT SUPPORTED
kubectl create -f ./1.21/roles.yaml

# Switch to new api. 
kubectl create -f ./1.22/roles.yaml
kubectl create -f ./1.22/bindings.yaml
# run a pod 
kubectl create -f ./1.22/pod.yaml -n versions-test

kubectl get all -n versions-test
# it looks like it upgrades the apis on install
kubectl get Role,RoleBindings -n versions-test -o yaml | yq .
```

### Remove Cluster

```sh
# get names
kind get clusters
# delete a cluster
kind delete cluster --name kind-1-21
```

## Resources

* kubernetes repo github [here](https://github.com/kubernetes/kubernetes)  
* kubernetes/releases github [here](https://github.com/kubernetes/kubernetes/releases)
* Deprecated API Migration Guide [here](https://kubernetes.io/docs/reference/using-api/deprecation-guide/)  
* rikatz/kubepug repo [here](https://github.com/rikatz/kubepug)

### EKS

* Best Practices for Cluster Upgrades [here](https://aws.github.io/aws-eks-best-practices/upgrades/)
* Amazon EKS Kubernetes versions [here](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html)
* Amazon EKS Kubernetes release calendar [here](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html#kubernetes-release-calendar)
