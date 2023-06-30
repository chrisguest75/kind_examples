# PODINFO

TODO:

* Add ingress
* Add multiple deyployments

## Pulling

```sh
# add repo
export CHART_REPOSITORY=podinfo
export CHART_NAME=podinfo
export REPOSITORY_URL=https://stefanprodan.github.io/podinfo
export CHART_VERSION=5.2.1
export CHART_VERSION=6.3.6
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

## Install chart

```sh
# check the context
kubectx
# install
helm upgrade ${CHART_NAME} --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} --namespace ${CHART_NAME} --create-namespace
```

## Use

```sh
kubectl -n podinfo port-forward deploy/podinfo 8080:9898

open http://0.0.0.0:8080
```

## Remove

```sh
# uninstall the chart
helm uninstall ${CHART_NAME} --namespace ${CHART_NAME}
```

## Resources

* podinfo repo [here](https://github.com/stefanprodan/podinfo)  
* artifacthub podinfo [here](https://artifacthub.io/packages/helm/podinfo/podinfo)  
