# HONEYCOMB AGENT

Demonstrate how to install vedaccio npm proxy.  

NOTES:

* Works as an NPM cache

## Pulling Verdaccio

```sh
export CHART_REPOSITORY=verdaccio
export CHART_NAME=verdaccio
export REPOSITORY_URL=https://charts.verdaccio.org
export CHART_VERSION=4.0.0
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

### Render Verdaccio

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

## Install Verdaccio

```sh
# check the context
kubectx
# install
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./charts/verdaccio-4.0.0.yaml

kubectl get pods --all-namespaces
```

## Resources

* Verdaccio - A lightweight Node.js private proxy registry [here](https://verdaccio.org/)
* Verdaccio Charts (Helm) [here](https://charts.verdaccio.org/)
* verdaccio/verdaccio repos [here](https://github.com/verdaccio/verdaccio)
* verdaccio/charts repos [here](https://github.com/verdaccio/charts)
