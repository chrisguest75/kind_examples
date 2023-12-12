# SESSION AFFINITY

Create an example that uses the official `ingress-nginx` with session affinity  

TODO:

* Add a container to the kind network and use ingress to test affinity.  
* Why doesn't the podinfo image work?  The api call in the page is not going to the correct endpoint http://localhost/podinfo/api/.  

NOTES:

* `nginx.ingress.kubernetes.io/upstream-hash-by` is used for affinity
* Uses `ingress-nginx` chart to install ingress for kind
* Uses `podinfo` chart.

## Build cluster

```sh
# create the cluster
kind create cluster --config affinity_cluster.yaml --name myingress

kubectx

# show cluster details
kubectl cluster-info --context kind-myingress

# show cluster info dump
kubectl cluster-info dump
```

## INGRESS-NGINX

Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer

```sh
export CHART_REPOSITORY=ingress-nginx
export CHART_NAME=ingress-nginx
export REPOSITORY_URL=https://kubernetes.github.io/ingress-nginx
export CHART_VERSION=4.7.0
```

## PULLING, RENDERING & DIFFING

### Pulling

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

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} --version ${CHART_VERSION} -f ./${CHART_NAME}-values.yaml --namespace ingress-nginx > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml
```

## Install

```sh
helm upgrade -f ./${CHART_NAME}-values.yaml --install ${CHART_NAME} ${CHART_NAME} --version ${CHART_VERSION} --repo ${REPOSITORY_URL} --namespace ${CHART_NAME} --create-namespace

kubectl get pods --all-namespaces

kubectl get pods --namespace=ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

## PODINFO

Podinfo Helm chart for Kubernetes  

```sh
# add repo
export CHART_REPOSITORY=podinfo
export CHART_NAME=podinfo
export REPOSITORY_URL=https://stefanprodan.github.io/podinfo
export CHART_VERSION=6.3.6

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} --version ${CHART_VERSION} -f ./${CHART_NAME}-values.yaml --namespace ${CHART_NAME} > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml

# output 
helm upgrade -f ./${CHART_NAME}-values.yaml --install ${CHART_NAME} ${CHART_NAME} --version ${CHART_VERSION} --repo ${REPOSITORY_URL} --namespace ${CHART_NAME} --create-namespace

# CHECK HOSTNAME IS ALWAYS THE SAME.
curl http://localhost:8080/podinfo

kubectl -n ${CHART_NAME} port-forward deploy/podinfo 8081:9898
open http://0.0.0.0:8081

# remove chart
helm uninstall ${CHART_NAME} --namespace ${CHART_NAME}
helm ls --all-namespaces                    
```

## Compare with ingress chart

Compare the kind ingress with ingress-nginx to work out the values.  

```sh
# create output folder
mkdir -p ./out
```

Export object names and kinds.  

```sh
cat ./charts/ingress-nginx-4.7.0-test.yaml | yq ". | [.apiVersion, .kind, .metadata.name]" > ./out/chart.yaml
cat ./charts/kind_ingress_nginx_patch.yaml | yq ". | [.apiVersion, .kind, .metadata.name]" > ./out/kind.yaml
```

Now split the charts.  

```sh
helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./${CHART_NAME}-values.yaml --namespace ingress-nginx > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml

# split chart into files
mkdir -p ./out/chart
cd ./out/chart
cat ../../charts/ingress-nginx-4.7.0-test.yaml | yq -P 'sort_keys(..)' -s '"resource_" + .kind + "_" + .metadata.name'
cd ../..

# split the kind ingress into files
mkdir -p ./out/kind
cd ./out/kind
cat ../../charts/kind_ingress_nginx_patch.yaml | yq -P 'sort_keys(..)' -s '"resource_" + .kind + "_" + .metadata.name'
cd ../..

# now compare for differences
bcompare ./out/chart ./out/kind
```

## Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name kind-myingress

kubectx -d kind-myingress  
```

## Resources

* kubernetes/ingress-nginx repo [here](https://github.com/kubernetes/ingress-nginx)
* Ingress-Nginx Controller Installation Guide [here](https://kubernetes.github.io/ingress-nginx/deploy/)
* Ingress-Nginx Controller Quick Start [here](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start)
