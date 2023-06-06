# README

Demonstrate how to use the HPA for scaling.

## Prereqs

```sh
brew install helm   
```

## Prepare

```sh
kind create cluster --config 1node_cluster.yaml --name mykind
kubectx
```

## Bitnami metrics server

The bitnami metrics server is required to host the metrics API

Repo can be found [here](https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server)
Helm chart [here](https://artifacthub.io/packages/helm/bitnami/metrics-server)

Copied the values from here. 
https://raw.githubusercontent.com/bitnami/charts/master/bitnami/metrics-server/values.yaml

```sh
# look at the repos already added
helm repo list 

# add bitnami metrics server
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install -f values.yaml my-metrics bitnami/metrics-server
```

```sh
# test the endpoint
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
```

The response should look like this.  

```json
{"kind":"NodeMetricsList","apiVersion":"metrics.k8s.io/v1beta1","metadata":{},"items":[{"metadata":{"name":"mykind-control-plane","creationTimestamp":"2021-09-23T08:37:37Z","labels":{"beta.kubernetes.io/arch":"amd64","beta.kubernetes.io/os":"linux","kubernetes.io/arch":"amd64","kubernetes.io/hostname":"mykind-control-plane","kubernetes.io/os":"linux","node-role.kubernetes.io/control-plane":"","node-role.kubernetes.io/master":"","node.kubernetes.io/exclude-from-external-load-balancers":""}},"timestamp":"2021-09-23T08:36:45Z","window":"51s","usage":{"cpu":"277712796n","memory":"693412Ki"}},{"metadata":{"name":"mykind-worker","creationTimestamp":"2021-09-23T08:37:37Z","labels":{"beta.kubernetes.io/arch":"amd64","beta.kubernetes.io/os":"linux","kubernetes.io/arch":"amd64","kubernetes.io/hostname":"mykind-worker","kubernetes.io/os":"linux"}},"timestamp":"2021-09-23T08:36:49Z","window":"1m0s","usage":{"cpu":"93433003n","memory":"323568Ki"}}]}
```

## Configure deployment

```sh
# Add deployment and service 
kubectl create -f ./deployment_podinfo.yaml
# view pods
kubectl get all 

# add the hpa
kubectl autoscale deployment deployment --cpu-percent=20 --min=1 --max=10 

# kickstart an ubuntu pod
kubectl run testubuntu --image=ubuntu:18.04 -n default --limits="cpu=200m,memory=512Mi" --restart=Never -- /bin/sh -c "sleep 10000"

# get ip addresses
kubectl get services podinfo
kubectl get endpoints podinfo
```

Jump onto the ubuntu container  

```sh
# shell into it
kubectl exec -it testubuntu -- /bin/sh

# install some tools
apt update
apt install curl dnsutils iputils-ping telnet -y 

# make requests
dig podinfo.default.svc.cluster.local 
curl podinfo.default.svc.cluster.local

# Install apache bench to stress it.
apt-get install apache2-utils -y
ab -n 10000 -c 3000 http://podinfo.default.svc.cluster.local/env
ab -n 10000 -c 3000 http://podinfo.default.svc.cluster.local/delay/5
```

```sh
 kubectl top pods
# on host view the pods
kubectl get all 
```

## Cleanup

```sh
helm delete my-metrics  
# kill the cluster
kind delete cluster --name mykind 
```

## Troubleshooting Metrics Server

```sh
kubectl get all
kubectl get pods --all-namespaces        

export POD=my-metrics-metrics-server-5b5898644f-bbpv8 
kubectl get pods $POD -o yaml

kubectl describe pods $POD

kubectl logs $POD -n default
```

## Resources

* Example of using HPA
 https://javamana.com/2021/06/20210618115631001y.html
* Podinfo [here](https://github.com/stefanprodan/podinfo)
