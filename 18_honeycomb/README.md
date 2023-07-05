# HONEYCOMB

NOTES:

* Ships logs to honeycomb
* Ships node and pod metrics to honeycomb

TODO:

* Find some queries that allow me to alert on failing pods
* Try otel collector.  

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_21_cluster.yaml --name kind-1-21
kind create cluster --config 1node_1_23_cluster.yaml --name kind-1-23
```

## Pulling Honeycomb Agent

```sh
export CHART_REPOSITORY=honeycomb
export CHART_NAME=honeycomb
export REPOSITORY_URL=https://honeycombio.github.io/helm-charts
export CHART_VERSION=1.7.1
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

### Render Honeycomb Agent

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

## Install Honeycomb Agent

```sh
# check the context
kubectx
# install
set -a
. ./.env
set +a
# or
export APIKEY=xxxxxxxxxxxxxxxxxxxx
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME} --set honeycomb.apiKey=$APIKEY

kubectl get pods --all-namespaces
```

## Install Honeycomb Dashboards

Use terraform to install kubernetes_starter_pack dashboards [README.md](kubernetes_starter_pack/README.md)  

## Install Services

### Podinfo

Install injecting failures podinfo [README.md](../17_podinfo/README.md)  

## Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name kind-1-23

kubectx -d kind-1-23
```

## Resources

* artifacthub honeycomb [here](https://artifacthub.io/packages/helm/honeycomb/honeycomb)
* terraform-honeycombio-kubernetes-starter-pack repo [here](https://github.com/honeycombio/terraform-honeycombio-kubernetes-starter-pack)
* Honeycomb Kubernetes Agent [here](https://docs.honeycomb.io/integrations/kubernetes/honeycomb-kubernetes-agent/)
* Kubernetes and Honeycomb [here](https://docs.honeycomb.io/integrations/kubernetes/)
* Resolving High CPU Usage in Kubernetes With Honeycomb [here](https://www.honeycomb.io/blog/diving-into-kubernetes-clusters-with-honeycomb)
* OpenTelemetry Operator for Kubernetes [here](https://opentelemetry.io/docs/k8s-operator/)
* Collecting Kubernetes Data Using OpenTelemetry [here](https://www.honeycomb.io/blog/kubernetes-collector-opentelemetry)  
