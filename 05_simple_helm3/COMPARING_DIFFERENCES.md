# COMPARING DIFFERENCES

Downloading and comparing helm charts before releasing them onto a cluster.  

## PODINFO

Podinfo Helm chart for Kubernetes  

```sh
# add repo
export CHART_REPOSITORY=podinfo
export CHART_NAME=podinfo
export REPOSITORY_URL=https://stefanprodan.github.io/podinfo
export CHART_VERSION=5.2.1
export CHART_VERSION=6.3.6
```

## AWS-VPC-CNI

This chart installs the AWS CNI Daemonset.

```sh
# add repo
export CHART_REPOSITORY=eks
export CHART_NAME=aws-vpc-cni
export REPOSITORY_URL=https://aws.github.io/eks-charts
export CHART_VERSION=1.13.2
```

## CNI-METRICS-HELPER

Chart provides a Kubernetes deployment for the Amazon VPC CNI Metrics Helper, which is used to collect metrics for the Amazon VPC CNI plugin for Kubernetes.

```sh
# add repo
export CHART_REPOSITORY=eks
export CHART_NAME=cni-metrics-helper 
export REPOSITORY_URL=https://aws.github.io/eks-charts
export CHART_VERSION=1.13.2
```

## EXTERNAL-DNS

ExternalDNS synchronizes exposed Kubernetes Services and Ingresses with DNS providers.  

```sh
# add repo
export CHART_REPOSITORY=external-dns
export CHART_NAME=external-dns
export REPOSITORY_URL=https://kubernetes-sigs.github.io/external-dns/
export CHART_VERSION=1.2.0
export CHART_VERSION=1.6.0
export CHART_VERSION=1.13.0  
```

## KUBERNETES-DASHBOARD

General-purpose web UI for Kubernetes clusters  

```sh
# add repo
export CHART_REPOSITORY=kubernetes-dashboard
export CHART_NAME=kubernetes-dashboard
export REPOSITORY_URL=https://kubernetes.github.io/dashboard/
export CHART_VERSION=6.0.8 
```

## INGRESS-NGINX

Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer

```sh
export CHART_REPOSITORY=ingress-nginx
export CHART_NAME=ingress-nginx
export REPOSITORY_URL=https://kubernetes.github.io/ingress-nginx
export CHART_VERSION=4.0.1
```

## SEALED SECRETS

Sealed Secrets are "one-way" encrypted K8s Secrets that can be created by anyone, but can only be decrypted by the controller running in the target cluster recovering the original object.  

```sh
export CHART_REPOSITORY=sealed-secrets
export CHART_NAME=sealed-secrets
export REPOSITORY_URL=https://bitnami-labs.github.io/sealed-secrets
export CHART_VERSION=2.10.0
```

## SECRETS-STORE-CSI-DRIVER

A Helm chart to install the SecretsStore CSI Driver inside a Kubernetes cluster.  

NOTE: You install a driver then install a provider than uses the driver.  i.e. AWS one

```sh
export CHART_REPOSITORY=secrets-store-csi-driver
export CHART_NAME=secrets-store-csi-driver
export REPOSITORY_URL=https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
export CHART_VERSION=0.0.22
export CHART_VERSION=0.3.0 
export CHART_VERSION=1.0.0 
export CHART_VERSION=1.3.4 
```

## CSI-SECRETS-STORE-PROVIDER-AWS

The AWS provider for the Secrets Store CSI Driver allows you to make secrets stored in Secrets Manager and parameters stored in Parameter Store appear as files mounted in Kubernetes pods.  

```sh
export CHART_REPOSITORY=aws-secrets-manager
export CHART_NAME=secrets-store-csi-driver-provider-aws
export REPOSITORY_URL=https://aws.github.io/secrets-store-csi-driver-provider-aws
export CHART_VERSION=0.3.3
```

## PULLING, RENDERING & DIFFING

### Pulling

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

## Resources

* artifacthub sealed-secrets [here](https://artifacthub.io/packages/helm/bitnami-labs/sealed-secrets)  
* artifacthub aws-vpc-cni [here](https://artifacthub.io/packages/helm/aws/aws-vpc-cni)  
* https://github.com/aws/amazon-vpc-cni-k8s
* artifacthub cni-metrics-helper [here](https://artifacthub.io/packages/helm/aws/cni-metrics-helper)  
* external-dns repo [here](https://github.com/kubernetes-sigs/external-dns)  
* artifacthub external-dns [here](https://artifacthub.io/packages/helm/external-dns/external-dns)  
* Kubernetes Dashboard repo [here](https://github.com/kubernetes/dashboard)  
* artifacthub k8s-dashboard [here](https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard)  
* podinfo repo [here](https://github.com/stefanprodan/podinfo)  
* artifacthub podinfo [here](https://artifacthub.io/packages/helm/podinfo/podinfo)  
* secrets-store-csi-driver repo [here](https://github.com/kubernetes-sigs/secrets-store-csi-driver)
* artifacthub secrets-store-csi-driver [here](https://artifacthub.io/packages/helm/secret-store-csi-driver/secrets-store-csi-driver)  
* secrets-store-csi-driver-provider-aws repo [here](https://github.com/aws/secrets-store-csi-driver-provider-aws)
* secrets-store-csi-driver-provider-aws [here](https://aws.github.io/secrets-store-csi-driver-provider-aws/)  
* https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx