# HONEYCOMB AGENT

Demonstrate how to install vedaccio npm proxy.  

NOTES:

* Works as an NPM cache

TODO:

* Configure NPM to use as a local cache.
* Verify packages can be published
* Configure htpasswd

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


# add the following to the values.yaml
  extraEnvVars:
  - name: VERDACCIO_PORT
    value: "4873"

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml --namespace kube-system > ./charts/${CHART_NAME}-${CHART_VERSION}-test.yaml
```

## Install Verdaccio

```sh
# check the context
kubectx
# install
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./charts/verdaccio-4.0.0.yaml

kubectl get pods --all-namespaces

# check it works
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=verdaccio,app.kubernetes.io/instance=verdaccio" -o jsonpath="{.items[0].metadata.name}")
export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT

curl http://127.0.0.1:8080
```

## Resources

* Verdaccio - A lightweight Node.js private proxy registry [here](https://verdaccio.org/)
* Verdaccio Charts (Helm) [here](https://charts.verdaccio.org/)
* verdaccio/verdaccio repos [here](https://github.com/verdaccio/verdaccio)
* verdaccio/charts repos [here](https://github.com/verdaccio/charts)
* Trying to get https working with dockerfile [#182](https://github.com/verdaccio/verdaccio/issues/182)