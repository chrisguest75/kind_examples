# External-DNS

ExternalDNS synchronizes exposed Kubernetes Services and Ingresses with DNS providers.

## Pull

```sh
# add repo
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

# find chart
helm search repo external-dns
# find versions of a chart 
helm search repo external-dns --versions

# pull chart
mkdir -p ./charts
export CHART_VERSION=1.2.0
export CHART_VERSION=1.6.0
export CHART_VERSION=1.13.0  
helm pull external-dns/external-dns --version ${CHART_VERSION} --untar --untardir ./charts/external-dns-${CHART_VERSION}
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values external-dns -n mynamespace > ./charts/external-dns-${CHART_VERSION}.yaml
# or create blank file
touch ./charts/external-dns-${CHART_VERSION}.yaml
helm template external-dns ./charts/external-dns-${CHART_VERSION}/external-dns -f ./charts/external-dns-${CHART_VERSION}/external-dns-values.yaml --namespace kube-system > ./charts/external-dns-${CHART_VERSION}-test.yaml
```

## Resources

* external-dns repo [here](https://github.com/kubernetes-sigs/external-dns)  
* artifacthub external-dns [here](https://artifacthub.io/packages/helm/external-dns/external-dns)  
