# Podinfo

Podinfo Helm chart for Kubernetes  

## Pull

```sh
# add repo
helm repo add podinfo https://stefanprodan.github.io/podinfo

helm search repo podinfo
# find versions of a chart 
helm search repo podinfo --versions

# pull chart
mkdir -p ./charts
export CHART_VERSION=5.2.1
helm pull podinfo/podinfo --version ${CHART_VERSION} --untar --untardir ./charts/podinfo-${CHART_VERSION}
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values podinfo -n mynamespace > ./charts/podinfo-${CHART_VERSION}.yaml
# or create blank file
touch ./charts/podinfo-${CHART_VERSION}.yaml
helm template podinfo ./charts/podinfo-${CHART_VERSION}/podinfo -f ./charts/podinfo-${CHART_VERSION}/podinfo-values.yaml --namespace default > ./charts/podinfo-${CHART_VERSION}-test.yaml
```

## Resources

* podinfo repo [here](https://github.com/stefanprodan/podinfo)  
* artifacthub podinfo [here](https://artifacthub.io/packages/helm/podinfo/podinfo)  
