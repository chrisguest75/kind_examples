# HONEYCOMB

Demonstrate how to get metrics from cluster to `honeycomb`  

## Reason

There are two methods of getting kubernetes metrics to honeycomb.  

* Honeycomb Agent
* OTEL Collector

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

Jump to and follow `injecting failures` podinfo [README.md](../17_podinfo/README.md)  
Also add the `healthy` podinfo example.  

The cluster should now have a few failing services that we can try to detect.  

## Install Honeycomb Agent

Install [HONEYCOMB_AGENT.md](./HONEYCOMB_AGENT.md)  

NOTES:

* Honeycomb Agent is technically in maintenance.  
* The kubernetes_starter_pack dashboards only work with the agent [README.md](kubernetes_starter_pack/README.md)  

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
