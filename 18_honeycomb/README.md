# HONEYCOMB

TODO:

* Find some queries that allow me to alert on failing pods

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_21_cluster.yaml --name kind-1-21
kind create cluster --config 1node_1_23_cluster.yaml --name kind-1-23
```

## Install Services

### Podinfo

Install injecting failures podinfo [README.md](../17_podinfo/README.md)  

## Install Honeycomb Agent

Install [HONEYCOMB_AGENT.md](./HONEYCOMB_AGENT.md)  

## Install OTEL Collector

Install [OTEL_COLLECTOR.md](./OTEL_COLLECTOR.md)  

## Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name kind-1-23

kubectx -d kind-1-23
```

## Resources

* artifacthub honeycomb [here](https://artifacthub.io/packages/helm/honeycomb/honeycomb)
* terraform-honeycombio-kubernetes-starter-pack repo [here](https://github.com/honeycombio/terraform-honeycombio-kubernetes-starter-pack)
* Honeycomb Kubernetes Agent [here](https://docs.honeycomb.io/integrations/kubernetes/honeycomb-kubernetes-agent/)
* Kubernetes and Honeycomb [here](https://docs.honeycomb.io/integrations/kubernetes/)
* Resolving High CPU Usage in Kubernetes With Honeycomb [here](https://www.honeycomb.io/blog/diving-into-kubernetes-clusters-with-honeycomb)
* OpenTelemetry Operator for Kubernetes [here](https://opentelemetry.io/docs/k8s-operator/)
* Collecting Kubernetes Data Using OpenTelemetry [here](https://www.honeycomb.io/blog/kubernetes-collector-opentelemetry)  
