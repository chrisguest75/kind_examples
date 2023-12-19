# VERDACCIO

Demonstrate how to configure `verdaccio` npm cache locally on `Kind`  

TODO:

* Configure NPM to use as a local cache.
* Verify packages can be published
* Configure htpasswd
* Metrics
* Plugins

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

* NPM Security best practices [here](https://cheatsheetseries.owasp.org/cheatsheets/NPM_Security_Cheat_Sheet.html)  
* Verdaccio - A lightweight Node.js private proxy registry [here](https://verdaccio.org/)
* Verdaccio Charts (Helm) [here](https://charts.verdaccio.org/)
* verdaccio/verdaccio repos [here](https://github.com/verdaccio/verdaccio)
* verdaccio/charts repos [here](https://github.com/verdaccio/charts)

## Plugins

* Plugin Search / Tools [here](https://verdaccio.org/dev/plugins-search/)
* xlts-dev/verdaccio-prometheus-middleware [here](https://github.com/xlts-dev/verdaccio-prometheus-middleware)  
