# secrets-store-csi-driver

A Helm chart to install the SecretsStore CSI Driver inside a Kubernetes cluster.  

NOTE: You install a driver then install a provider than uses the driver.  i.e. AWS one

## Pull

```sh
# add repo
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts

# find chart
helm search repo secrets-store-csi-driver
# find versions of a chart 
helm search repo secrets-store-csi-driver --versions   

# pull chart
mkdir -p ./charts
export CHART_VERSION=0.0.22
export CHART_VERSION=0.3.0 
export CHART_VERSION=1.0.0 
export CHART_VERSION=1.3.4 
helm pull secrets-store-csi-driver/secrets-store-csi-driver --version ${CHART_VERSION} --untar --untardir ./charts/secrets-store-csi-driver-${CHART_VERSION}
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values secrets-store-csi-driver -n mynamespace > ./charts/secrets-store-csi-driver-${CHART_VERSION}/secrets-store-csi-driver.yaml 
# or create blank file
touch ./charts/secrets-store-csi-driver-${CHART_VERSION}/secrets-store-csi-driver.yaml 
helm template secrets-store-csi-driver ./charts/secrets-store-csi-driver-${CHART_VERSION}/secrets-store-csi-driver -f ./charts/secrets-store-csi-driver-${CHART_VERSION}/secrets-store-csi-driver.yaml --namespace kube-system > ./charts/secrets-store-csi-driver-${CHART_VERSION}-test.yaml
```

## Resources

* secrets-store-csi-driver repo [here](https://github.com/kubernetes-sigs/secrets-store-csi-driver)
* artifacthub secrets-store-csi-driver [here](https://artifacthub.io/packages/helm/secret-store-csi-driver/secrets-store-csi-driver)  
