# UPGRADES

Demonstrate some examples with upgrades.  

TODO:

* Create resources using deprecated and deleted APIs.  
* List them out and use kubepug to hightlight them.  

## 1.21 cluster

Create a 1.21 single node cluster.  

```sh
kind create cluster --config 1node_1_21_cluster.yaml --name kind-1-21
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

## Resources

* kubernetes repo github [here](https://github.com/kubernetes/kubernetes)  
* kubernetes/releases github [here](https://github.com/kubernetes/kubernetes/releases)
* Deprecated API Migration Guide [here](https://kubernetes.io/docs/reference/using-api/deprecation-guide/)  

https://github.com/rikatz/kubepug
https://aws.github.io/aws-eks-best-practices/upgrades/
https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html#kubernetes-release-calendar


