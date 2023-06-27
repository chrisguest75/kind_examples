# SEALED SECRETS

Sealed Secrets are "one-way" encrypted K8s Secrets that can be created by anyone, but can only be decrypted by the controller running in the target cluster recovering the original object.  

## NOTES

* Works in a similar way to SOPS in that you create the encoded secret then store in decrypted form on the server.  
* When uninstalling the chart it seems to leave resources on the cluster
* Copying a sealed secret and changing the resource names does not work - the secret never gets decrypted even though the sealedsecret resource is created.  

## TODO

* Is it cluster wide?
* Export the decrypt key into another server.

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_21_cluster.yaml --name kind-1-21
kind create cluster --config 1node_1_22_cluster.yaml --name kind-1-22
```

## Pulling

```sh
export CHART_REPOSITORY=sealed-secrets
export CHART_NAME=sealed-secrets
export REPOSITORY_URL=https://bitnami-labs.github.io/sealed-secrets
export CHART_VERSION=2.10.0
```

```sh
helm repo add ${CHART_REPOSITORY} ${REPOSITORY_URL}

# find chart
helm search repo ${CHART_REPOSITORY}
# find versions of a chart 
helm search repo ${CHART_REPOSITORY}/${CHART_NAME} --versions

# pull chart
mkdir -p ./charts
helm pull ${CHART_REPOSITORY}/${CHART_NAME} --version ${CHART_VERSION} --untar --untardir ./charts/${CHART_NAME}-${CHART_VERSION}
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values ${CHART_NAME} -n mynamespace > ./charts/${CHART_NAME}-${CHART_VERSION}.yaml
# or create blank file
touch ./charts/${CHART_NAME}-${CHART_VERSION}.yaml
# or copy them over
cp ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}/values.yaml ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml --namespace kube-system > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml
```

## Install kubeseal

```sh
mkdir -p ./kubeseal

# list releases 
gh release list -R bitnami-labs/sealed-secrets

# download release
gh release download v0.22.0  -R bitnami-labs/sealed-secrets -p kubeseal-0.22.0-darwin-amd64.tar.gz --output ./kubeseal/kubeseal-0.22.0-darwin-amd64.tar.gz
```

## Install chart

```sh
# check the context
kubectx
# install
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME}
```

## Seal secrets

```sh
mkdir -p ./secrets
kubectl create secret generic secret1 --dry-run=client --from-literal=foo=bar -o yaml > ./secrets/secret1.yaml
cat ./secrets/secret1.yaml | ./kubeseal/kubeseal-0.22.0-darwin-amd64/kubeseal --controller-name=sealed-secrets --controller-namespace=default --format yaml > ./secrets/sealedsecret1.yaml

kubectl create secret generic secret2 --dry-run=client --from-literal=food=bard -o yaml > ./secrets/secret2.yaml
cat ./secrets/secret2.yaml | ./kubeseal/kubeseal-0.22.0-darwin-amd64/kubeseal --controller-name=sealed-secrets --controller-namespace=default --format yaml > ./secrets/sealedsecret2.yaml

# create the sealed secret
kubectl create -f ./secrets/sealedsecret1.yaml

# get the secret
kubectl get secret secret1 -o yaml
```

## Uninstall chart

```sh
helm uninstall ${CHART_NAME}
# this works even though it's a new chart.  
kubectl create -f ./secrets/sealedsecret2.yaml
kubectl get secret secret2 -o yaml

# reinstall
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME}

kubectl create secret generic secret3 --dry-run=client --from-literal=foody=bardy -o yaml > ./secrets/secret3.yaml
cat ./secrets/secret3.yaml | ./kubeseal/kubeseal-0.22.0-darwin-amd64/kubeseal --controller-name=sealed-secrets --controller-namespace=default --format yaml > ./secrets/sealedsecret3.yaml

kubectl create -f ./secrets/sealedsecret3.yaml
kubectl get secret secret3 -o yaml
```

## Troubleshooting

```sh
# if there are any errors you can get the logs of the sealed secrets pod.  
kubectl logs sealed-secrets-6ffb6d7979-vbzn7
```

### Remove Cluster

```sh
# get names
kind get clusters
# delete a cluster
kind delete cluster --name kind-1-21
```

## Resources

* bitnami-labs/sealed-secrets repo [here](https://github.com/bitnami-labs/sealed-secrets)  
* artifacthub sealed-secrets [here](https://artifacthub.io/packages/helm/bitnami-labs/sealed-secrets)  
* Sealed Secrets for Kubernetes [here](https://medium.com/codex/sealed-secrets-for-kubernetes-722d643eb658)  
