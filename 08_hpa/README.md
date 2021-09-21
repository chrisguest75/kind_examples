# README

brew install helm   


kind create cluster --config 1node_cluster.yaml --name mykind


https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server
https://artifacthub.io/packages/helm/bitnami/metrics-server

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install -f values.yaml my-metrics bitnami/metrics-server
helm delete my-metrics  

helm repo add podinfo https://stefanprodan.github.io/podinfo




kubectl get pods --all-namespaces        


 kubectl get pods my-release-metrics-server-5d7bd5f8f-8479f  -o yaml

 kubectl describe pods my-release-metrics-server-5d7bd5f8f-8479f

 kubectl logs  my-metrics-metrics-server-6c6694fbfc-8th6j   -n default


kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"

Copied the values from here. 
https://raw.githubusercontent.com/bitnami/charts/master/bitnami/metrics-server/values.yaml


# Resources 
 https://javamana.com/2021/06/20210618115631001y.html