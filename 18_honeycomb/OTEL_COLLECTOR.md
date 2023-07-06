# OTEL COLLECTOR

Use the OTEL collector to collect metrics and logs.  

NOTES:

* The OTEL collector *seems* to require two deployments `daemonset` and `deployment` to collect everything.  
* It collects k8s events whereas the Honeycomb Agent doesn't seem to.  

TODO:

* Load the apikey values from secrets.

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

## Install OTEL Collector

```sh
# check the context
kubectx
# install
set -a
. ./.env
set +a
# or
export APIKEY=xxxxxxxxxxxxxxxxxxxx
helm upgrade ${CHART_NAME}-daemonset --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./opentelemetry-collector-daemon-values.yaml --namespace ${CHART_NAME} --create-namespace --set "config.exporters.otlp.headers.X-Honeycomb-Team=$APIKEY,config.exporters.otlp.headers.X-Honeycomb-Dataset=otel-collector-data"

helm upgrade ${CHART_NAME}-deployment --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./opentelemetry-collector-deployment-values.yaml --namespace ${CHART_NAME} --create-namespace --set "config.exporters.otlp.headers.X-Honeycomb-Team=$APIKEY,config.exporters.otlp.headers.X-Honeycomb-Dataset=otel-collector-data"

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
* open-telemetry/opentelemetry-operator repo [here](https://github.com/open-telemetry/opentelemetry-operator)  
* artifacthub opentelemetry-collector Helm chart [here](https://artifacthub.io/packages/helm/opentelemetry-helm/opentelemetry-collector)  
