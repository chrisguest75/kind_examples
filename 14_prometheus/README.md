# PROMETHEUS

Demonstrates installing prometheus onto a Kind cluster

TODO:

* Install podinfo deployment  
* Test it using multiple replicas and artillery
* HPA
* Better tests to drive behaviour I can monitor

## Prereqs

Install cluster using [Kind](https://github.com/chrisguest75/kind_examples)  
Install [Helm](https://helm.sh/docs/intro/install/)  

## Build cluster

```sh
# create the cluster
# the user token technique doesn't seem to work on 1.27
kind create cluster --config prometheus_cluster.yaml --name myprometheus --image kindest/node:v1.21.14@sha256:8a4e9bb3f415d2bb81629ce33ef9c76ba514c14d707f9797a01e3216376ba093

kubectx

# show cluster details
kubectl cluster-info --context kind-myprometheus

# show cluster info dump
kubectl cluster-info dump
```

## Install charts

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm search repo kube-prometheus-stack
# find versions of a chart 
helm search repo kube-prometheus-stack --versions

# pull chart
mkdir -p ./charts
export CHART_VERSION=47.0.0
helm pull prometheus-community/kube-prometheus-stack --version ${CHART_VERSION} --untar --untardir ./charts/prometheus-${CHART_VERSION}

helm install --wait --timeout 15m  --namespace monitoring --create-namespace --repo https://prometheus-community.github.io/helm-charts kube-prometheus-stack kube-prometheus-stack

```

## Find prometheus server (port forward)

```sh
export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 9090

open http://localhost:9090       
```

## Find grafana server (port forward)

```sh
# install grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm search repo grafana
helm install grafana grafana/grafana 

# port forward
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 3000

# get password
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

open http://localhost:3000     
```

## Grafana Dashboards

1. Add the following Prometheus datasource `http://prometheus-server.default.svc.cluster.local:80`
1. Import the default Prometheus v2.0 Dashbaord 

### Import

1. Prometheus 2.0 Overview - https://grafana.com/grafana/dashboards/3662
1. Kubernetes Deployment metrics - https://grafana.com/grafana/dashboards/741
1. kube-state-metrics-v2 - https://grafana.com/grafana/dashboards/13332


### Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name myprometheus

kubectx -d kind-myprometheus  
```

## Resource

* https://medium.com/@giorgiodevops/kind-install-prometheus-operator-and-fix-missing-targets-b4e57bcbcb1f
* https://github.com/grafana/helm-charts
* https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md
* prometheus-community/helm-charts [here](https://github.com/prometheus-community/helm-charts)

https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

https://github.com/kubernetes/kube-state-metrics

https://hub.kubeapps.com/charts/prometheus-community/kube-state-metrics




