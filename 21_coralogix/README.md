# CORALOGIX COLLECTOR

## Pulling

```sh
# add repo
export CHART_REPOSITORY=coralogix 
export CHART_NAME=coralogix-opentelemetry-integration 
export REPOSITORY_URL=https://cgx.jfrog.io/artifactory/coralogix-charts-virtual
export CHART_VERSION=0.12.1
```

```sh
helm version

helm repo add ${CHART_REPOSITORY} ${REPOSITORY_URL}
helm repo update

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

## Configure

When copying values for deployment to kind you'll need to remove all references to hostmetrics.  

```sh
. ./.env
helm version
kubectl create secret generic coralogix-opentelemetry-key --from-literal=PRIVATE_KEY="${CORALOGIX_KEY}"

helm upgrade --install infrastructure-agent coralogix/coralogix-opentelemetry-integration --version=0.12.1 --set global.domain="eu2.coralogix.com" --set global.clusterName="Local Kind" -f ./charts/${CHART_NAME}-tests-values.yaml
```

## Resources

