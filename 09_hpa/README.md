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
helm repo add podinfo https://stefanprodan.github.io/podinfo
```

## Cleanup
```sh
helm delete my-metrics  
```

## Troubleshooting
```sh
kubectl get pods --all-namespaces        

export POD=my-metrics-metrics-server-5b5898644f-bbpv8 
kubectl get pods $POD -o yaml

kubectl describe pods $POD

kubectl logs $POD -n default
```

# Resources 
* Example of using HPA
 https://javamana.com/2021/06/20210618115631001y.html