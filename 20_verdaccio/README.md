# VERDACCIO

Demonstrate how to configure `verdaccio` npm cache locally on `Kind`  

## Reason

A local NPM cache.  

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_24_cluster.yaml --name kind-1-24
```

## Install Services

Install [VERDACCIO.md](./VERDACCIO.md)  

## Remove Cluster

```sh
kind get clusters   

kind delete -v 10 cluster --name kind-1-24

kubectx -d kind-1-24
```

## Resources

* Verdaccio - A lightweight Node.js private proxy registry [here](https://verdaccio.org/)
* Verdaccio Charts (Helm) [here](https://charts.verdaccio.org/)
* verdaccio/verdaccio repos [here](https://github.com/verdaccio/verdaccio)
* verdaccio/charts repos [here](https://github.com/verdaccio/charts)
