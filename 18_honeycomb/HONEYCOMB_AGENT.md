# HONEYCOMB AGENT

Demonstrate how to install the honeycomb agent with container metrics and eventrouter.  

NOTES:

* Ships logs to honeycomb
* Ships node, pod and container metrics to honeycomb
* `status.ready` is only available at the container level.
* Documentation says you can set eventrouter to output `json`.  But this doesn't work as it prefixes with `glog` meaning the parser does not seem to work. `I0719 11:55:34.426020       1 glogsink.go:42] {"verb":"ADDED",`  

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
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME} -f ./honeycomb-agent-values.yaml --set honeycomb.apiKey=$APIKEY

kubectl get pods --all-namespaces

# goto ui and environment
open https://ui.honeycomb.io/
```

## Install EventRouter

NOTE: To pull it locally use steps above with values below.  

```sh
export CHART_REPOSITORY=wikimedia
export CHART_NAME=eventrouter
export REPOSITORY_URL=https://helm-charts.wikimedia.org/stable/
export CHART_VERSION=0.4.1

# install it 
helm upgrade ${CHART_NAME} --install ${CHART_REPOSITORY}/${CHART_NAME} --namespace ${CHART_NAME} --create-namespace --set sink=glog
```

## Install Honeycomb Dashboards

Use terraform to install kubernetes_starter_pack dashboards [README.md](kubernetes_starter_pack/README.md)  

## Resources

* artifacthub honeycomb [here](https://artifacthub.io/packages/helm/honeycomb/honeycomb)
* terraform-honeycombio-kubernetes-starter-pack repo [here](https://github.com/honeycombio/terraform-honeycombio-kubernetes-starter-pack)
* Honeycomb Kubernetes Agent [here](https://docs.honeycomb.io/integrations/kubernetes/honeycomb-kubernetes-agent/)
* Kubernetes and Honeycomb [here](https://docs.honeycomb.io/integrations/kubernetes/)
* Resolving High CPU Usage in Kubernetes With Honeycomb [here](https://www.honeycomb.io/blog/diving-into-kubernetes-clusters-with-honeycomb)
* OpenTelemetry Operator for Kubernetes [here](https://opentelemetry.io/docs/k8s-operator/)
* Collecting Kubernetes Data Using OpenTelemetry [here](https://www.honeycomb.io/blog/kubernetes-collector-opentelemetry)  
