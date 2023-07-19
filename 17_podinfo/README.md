# PODINFO

Podinfo Helm chart for Kubernetes  

NOTES:

* Quickly create multiple deyployments
* Can be used with [18_honeycomb](../18_honeycomb/README.md) for monitoring failures

TODO:

* Add ingress
* Work out how to monitor individual services from restarts, errimagepull, etc.

## Pulling

```sh
# add repo
export CHART_REPOSITORY=podinfo
export CHART_NAME=podinfo
export REPOSITORY_URL=https://stefanprodan.github.io/podinfo
export CHART_VERSION=5.2.1
# kube 1.23+
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
helm upgrade ${CHART_NAME} --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} --namespace ${CHART_NAME}-healthy --create-namespace

kubectl get pods --all-namespaces
```

## Use

```sh
kubectl -n ${CHART_NAME}-healthy port-forward deploy/podinfo 8080:9898

open http://0.0.0.0:8080
```

## Injecting Failures

Use flags in `podinfo` to cause common types of failure.  

NOTE: You can install multiple types of failure to different namespaces.  

```sh
# install "the healthy state is never reached"
helm upgrade ${CHART_NAME} --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} --namespace ${CHART_NAME}-unhealthy --create-namespace --set "faults.unhealthy=true,replicaCount=3"

# install "the ready state is never reached"
helm upgrade ${CHART_NAME} --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} --namespace ${CHART_NAME}-unready --create-namespace --set "faults.unready=true,replicaCount=3"

# install "missing tag"
helm upgrade ${CHART_NAME} --version ${CHART_VERSION} --install ${CHART_REPOSITORY}/${CHART_NAME} --namespace ${CHART_NAME}-missingtag --create-namespace --set "image.tag=100.100.100,replicaCount=3"

# causes the healthy pods to crash (port-forward background)
kubectl -n ${CHART_NAME}-healthy port-forward deploy/podinfo 8080:9898 & 
curl http://0.0.0.0:8080/panic

kubectl get pods --all-namespaces
```

## Fix Failures

Use these to see how quickly the triggers resolve.  

```sh
helm uninstall ${CHART_NAME} --namespace ${CHART_NAME}-unhealthy 

helm uninstall ${CHART_NAME} --namespace ${CHART_NAME}-unready 

helm uninstall ${CHART_NAME} --namespace ${CHART_NAME}-missingtag
```

## Remove

```sh
# uninstall the chart
helm uninstall ${CHART_NAME} --namespace ${CHART_NAME}-healthy
```

## Resources

* podinfo repo [here](https://github.com/stefanprodan/podinfo)  
* artifacthub podinfo [here](https://artifacthub.io/packages/helm/podinfo/podinfo)  
