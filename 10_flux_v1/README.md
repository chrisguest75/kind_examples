# FLUXV1

Compare versions of fluxv1 charts.  

## Pulling

```sh
# add helm-operator
export CHART_REPOSITORY=helm-operator 
export CHART_NAME=helm-operator
export REPOSITORY_URL=https://charts.fluxcd.io
export CHART_VERSION=1.2.0
export CHART_VERSION=1.4.4
```

```sh
# add fluxcd
export CHART_REPOSITORY=fluxcd 
export CHART_NAME=flux
export REPOSITORY_URL=https://charts.fluxcd.io
export CHART_VERSION=1.9.0
export CHART_VERSION=1.13.3
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

```txt
NAME                            CHART VERSION   APP VERSION     DESCRIPTION                                       
helm-operator/helm-operator     1.4.4           1.4.4           Flux Helm Operator is a CRD controller for decl...
helm-operator/flux              1.13.3          1.25.4          Flux is a tool that automatically ensures that ...
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# or copy them over
cp ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}/values.yaml ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml

helm template ${CHART_NAME} ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME} -f ./charts/${CHART_NAME}-${CHART_VERSION}/${CHART_NAME}-values.yaml --namespace flux > ./charts/${CHART_NAME}-${CHART_VERSION}-rendered.yaml
```

## Resources

