# SESSION AFFINITY

Create an example that uses the official ingress-nginx with session affinity

nginx.ingress.kubernetes.io/upstream-hash-by

## Build cluster

```sh
# create the cluster
kind create cluster --config affinity_cluster.yaml --name myingress

kubectx

# show cluster details
kubectl cluster-info --context kind-myingress

# show cluster info dump
kubectl cluster-info dump
```

## Install

```sh
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace

kubectl get pods --all-namespaces      



helm show values ingress-nginx --repo https://kubernetes.github.io/ingress-nginx

kubectl get pods --namespace=ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s


kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo

kubectl create ingress demo-localhost --class=nginx \
  --rule="demo.localdev.me/*=demo:80"

kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80


curl --resolve demo.localdev.me:8080:127.0.0.1 http://demo.localdev.me:8080

curl http://127.0.0.1:8080
```

## Resources

https://github.com/kubernetes/ingress-nginx
https://kubernetes.github.io/ingress-nginx/deploy/
https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#config-file
