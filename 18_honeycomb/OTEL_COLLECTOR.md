# OTEL COLLECTOR

Use the OTEL collector to collect metrics and logs.  

NOTES:

* The OTEL collector *seems* to require two deployments `daemonset` and `deployment` to collect everything.  
* It collects k8s events whereas the Honeycomb Agent doesn't seem to.  

TODO:

* Look at readiness values  
* Image pull transform json from events.  https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/processor/transformprocessor#parsing-json-logs
* setup dashboards for otel collector - map metrics and alter module.
* configure collector to pull labels - https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/processor/k8sattributesprocessor

## Pulling OTEL Collector

```sh
export CHART_REPOSITORY=open-telemetry
export CHART_NAME=opentelemetry-collector
export REPOSITORY_URL=https://open-telemetry.github.io/opentelemetry-helm-charts
export CHART_VERSION=0.61.2
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

### Render OTEL Collector

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values ${CHART_NAME} -n mynamespace > ./charts/${CHART_NAME}-${CHART_VERSION}.yaml
# or create blank file
touch ./charts/${CHART_NAME}-${CHART_VERSION}.yaml
# or copy them over
cp ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}/values.yaml ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml --namespace kube-system --set mode=daemonset > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml
```

## Install OTEL Collector (use secret)

```sh
# check the context
kubectx
# install
set -a
. ./.env
set +a
# or
export APIKEY=xxxxxxxxxxxxxxxxxxxx

kubectl create namespace ${CHART_NAME}     
kubectl --namespace ${CHART_NAME} create secret generic honeycomb-apikey --from-literal=HONEYCOMB_APIKEY=${APIKEY}
kubectl get secrets -n $CHART_NAME honeycomb-apikey -o yaml

helm upgrade ${CHART_NAME}-daemonset --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./opentelemetry-collector-daemon-values.yaml --namespace ${CHART_NAME} --create-namespace --set "config.exporters.otlp.headers.X-Honeycomb-Dataset=otel-collector-data"

helm upgrade ${CHART_NAME}-deployment --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./opentelemetry-collector-deployment-values.yaml --namespace ${CHART_NAME} --create-namespace --set "config.exporters.otlp.headers.X-Honeycomb-Dataset=otel-collector-data"

kubectl get pods --all-namespaces
kubectl -n ${CHART_NAME} get pods
```

## Install OTEL Collector (render apikey)

```sh
# check the context
kubectx
# install
set -a
. ./.env
set +a
# or
export APIKEY=xxxxxxxxxxxxxxxxxxxx

# NOTE: Both daemonset and deployment can log to same collection - here they are different.
helm upgrade ${CHART_NAME}-daemonset --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./opentelemetry-collector-daemon-values.yaml --namespace ${CHART_NAME} --create-namespace --set "config.exporters.otlp.headers.X-Honeycomb-Team=$APIKEY,config.exporters.otlp.headers.X-Honeycomb-Dataset=otel-collector-data-daemonset"

helm upgrade ${CHART_NAME}-deployment --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./opentelemetry-collector-deployment-values.yaml --namespace ${CHART_NAME} --create-namespace --set "config.exporters.otlp.headers.X-Honeycomb-Team=$APIKEY,config.exporters.otlp.headers.X-Honeycomb-Dataset=otel-collector-data-deployment"

kubectl get pods --all-namespaces
```

## Remove chart

```sh
# uninstall charts.
helm uninstall ${CHART_NAME}-daemonset --namespace ${CHART_NAME}
helm uninstall ${CHART_NAME}-deployment --namespace ${CHART_NAME}
```

## Resources

* Collecting Kubernetes Data Using OpenTelemetry [here](https://www.honeycomb.io/blog/kubernetes-collector-opentelemetry)  
* open-telemetry/opentelemetry-collector repo [here](https://github.com/open-telemetry/opentelemetry-collector)  
* open-telemetry/opentelemetry-operator repo [here](https://github.com/open-telemetry/opentelemetry-operator)  
* artifacthub opentelemetry-collector Helm chart [here](https://artifacthub.io/packages/helm/opentelemetry-helm/opentelemetry-collector)  
* Provide ability to Load an Existing Secret or Create a New Secret to Datadog. [here](https://github.com/open-telemetry/opentelemetry-helm-charts/issues/31)  
