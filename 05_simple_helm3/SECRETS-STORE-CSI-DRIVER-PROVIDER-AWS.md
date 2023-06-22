# csi-secrets-store-provider-aws

The AWS provider for the Secrets Store CSI Driver allows you to make secrets stored in Secrets Manager and parameters stored in Parameter Store appear as files mounted in Kubernetes pods.  

NOTE: You install a driver then install a provider than uses the driver.  i.e. AWS one

## Pull

```sh
# add repo
helm repo add aws-secrets-manager https://aws.github.io/secrets-store-csi-driver-provider-aws

# find chart
helm search repo aws-secrets-manager/secrets-store-csi-driver-provider-aws
# find versions of a chart 
helm search repo aws-secrets-manager/secrets-store-csi-driver-provider-aws --versions   

# pull chart
mkdir -p ./charts
export CHART_VERSION=0.3.3

helm pull aws-secrets-manager/secrets-store-csi-driver-provider-aws --version ${CHART_VERSION} --untar --untardir ./charts/secrets-store-csi-driver-provider-aws-${CHART_VERSION}
```

## Render

Render the charts as a single file so they can be easily diffed and reviewed.  

```sh
# get values 
helm get values secrets-store-csi-driver-provider-aws -n mynamespace > ./charts/secrets-store-csi-driver-provider-aws-${CHART_VERSION}/secrets-store-csi-driver-provider-aws.yaml 
# or create blank file
touch ./charts/secrets-store-csi-driver-provider-aws-${CHART_VERSION}/secrets-store-csi-driver-provider-aws.yaml 
helm template secrets-store-csi-driver ./charts/secrets-store-csi-driver-provider-aws-${CHART_VERSION}/secrets-store-csi-driver-provider-aws -f ./charts/secrets-store-csi-driver-provider-aws-${CHART_VERSION}/secrets-store-csi-driver-provider-aws.yaml --namespace kube-system > ./charts/secrets-store-csi-driver-provider-aws-${CHART_VERSION}-test.yaml
```

## Resources

* secrets-store-csi-driver-provider-aws repo [here](https://github.com/aws/secrets-store-csi-driver-provider-aws)
* secrets-store-csi-driver-provider-aws [here](https://aws.github.io/secrets-store-csi-driver-provider-aws/)  
