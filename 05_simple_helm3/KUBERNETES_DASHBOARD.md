# Kubernetes Dashboard

General-purpose web UI for Kubernetes clusters

## Pull

```sh
# add repo
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm search repo kubernetes-dashboard
# find versions of a chart 
helm search repo kubernetes-dashboard --versions

# pull chart
mkdir -p ./charts
export CHART_VERSION=6.0.8 
helm pull kubernetes-dashboard/kubernetes-dashboard --version ${CHART_VERSION} --untar --untardir ./charts/kubernetes-dashboard-${CHART_VERSION}
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values kubernetes-dashboard -n kubernetes-dashboard > ./charts/kubernetes-dashboard-${CHART_VERSION}/kubernetes-dashboard-values.yaml
# or create blank file
touch ./charts/kubernetes-dashboard-${CHART_VERSION}.yaml
cp ./charts/kubernetes-dashboard-${CHART_VERSION}/kubernetes-dashboard/values.yaml ./charts/kubernetes-dashboard-${CHART_VERSION}/kubernetes-dashboard-values.yaml
helm template kubernetes-dashboard ./charts/kubernetes-dashboard-${CHART_VERSION}/kubernetes-dashboard -f ./charts/kubernetes-dashboard-${CHART_VERSION}/kubernetes-dashboard-values.yaml --namespace kubernetes-dashboard > ./charts/kubernetes-dashboard-${CHART_VERSION}-test.yaml
```

## Resources

* Kubernetes Dashboard repo [here](https://github.com/kubernetes/dashboard)  
* artifacthub k8s-dashboard [here](https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard)  
