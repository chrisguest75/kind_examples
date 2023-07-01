# SESSION AFFINITY

Create an example that uses the official ingress-nginx with session affinity

TODO:

* nginx.ingress.kubernetes.io/upstream-hash-by

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
export CHART_VERSION=4.0.1
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

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./${CHART_NAME}-values.yaml --namespace ingress-nginx > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml
```

## Install

```sh
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace

kubectl get pods --all-namespaces      



helm show values ingress-nginx --repo https://kubernetes.github.io/ingress-nginx

kubectl get pods --namespace=ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s


kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo

kubectl create ingress demo-localhost --class=nginx \
  --rule="demo.localdev.me/*=demo:80"

kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80


curl --resolve demo.localdev.me:8080:127.0.0.1 http://demo.localdev.me:8080

curl http://127.0.0.1:8080
```

## Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name kind-myingress

kubectx -d kind-myingress  
```





## Compare with ingress

```sh
mkdir -p ./out
cat ./charts/ingress-nginx-4.7.0-test.yaml | yq ". | [.apiVersion, .kind, .metadata.name]" > ./out/chart.yaml

cat ./charts/kind_ingress_nginx_patch.yaml | yq ". | [.apiVersion, .kind, .metadata.name]" > ./out/kind.yaml


helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./${CHART_NAME}-values.yaml --namespace ingress-nginx > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml


mkdir -p ./out/chart
cd ./out/chart
cat ../../charts/ingress-nginx-4.7.0-test.yaml | yq -P 'sort_keys(..)' -s '"resource_" + .kind + "_" + .metadata.name'
cd ../..

mkdir -p ./out/kind
cd ./out/kind
cat ../../charts/kind_ingress_nginx_patch.yaml | yq -P 'sort_keys(..)' -s '"resource_" + .kind + "_" + .metadata.name'
cd ../..

bcompare ./out/chart ./out/kind
```





## Resources

* https://github.com/kubernetes/ingress-nginx
* https://kubernetes.github.io/ingress-nginx/deploy/
* https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
* https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#config-file
