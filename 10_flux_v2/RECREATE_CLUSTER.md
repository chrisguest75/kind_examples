# RECREATING A CLUSTER

You've created a cluster and repository and now you want to rebuild the cluster from an existing repository.  

NOTE: Flux will detect if the repo already exists and start provisioning the cluster.  

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_27_cluster.yaml --name kind-1-27
```

## Install

```sh
# check your connection
kubectx

# source GITHUB_TOKEN
. ./.env

# bootstrap the cluster
flux bootstrap github \
  --token-auth \
  --owner=${GITHUB_USER} \
  --repository=fluxv2_deployment_test \
  --branch=main \
  --path=clusters/kind-kind-1-27 \
  --personal

# open k9s
k9s
```

## Resources