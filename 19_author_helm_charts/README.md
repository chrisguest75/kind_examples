# AUTHOR HELM CHARTS

TODO:

* Upload chart to docker registry and source it from there.  

## Author

```sh
# create template
helm create simple-nginx  

# duplicate values
cp ./simple-nginx/values.yaml ./simple-nginx-values.yaml

# render from values for evaluation
mkdir -p ./render
export CHART_NAME=simple-nginx
helm template ${CHART_NAME} ./${CHART_NAME} -f ./${CHART_NAME}-values.yaml --namespace apps > ./render/${CHART_NAME}-render.yaml
```

## Installation

```sh
# install
helm upgrade -f ./${CHART_NAME}-values.yaml --install ${CHART_NAME} ./${CHART_NAME} --namespace apps --create-namespace

helm ls --all-namespaces                

# CHECK HOSTNAME IS ALWAYS THE SAME.
curl http://localhost:8080/nginx-app
```

## Reverse Proxy - Podinfo

```sh
# create template
helm create custom-podinfo

# duplicate values
cp ./custom-podinfo/values.yaml ./custom-podinfo-values.yaml

# render from values for evaluation
mkdir -p ./render
export CHART_NAME=custom-podinfo
helm template ${CHART_NAME} ./${CHART_NAME} -f ./${CHART_NAME}-values.yaml --namespace apps > ./render/${CHART_NAME}-render.yaml
```

## Installation

```sh
# install
export INSTALL_NUMBER=1
export INSTALL_NUMBER=2

helm upgrade -f ./${CHART_NAME}-values.yaml --install ${CHART_NAME}-${INSTALL_NUMBER} ./${CHART_NAME} --namespace apps --create-namespace --set "ingress.hosts[0].paths[0].path=/custom-podinfo-${INSTALL_NUMBER},serviceAccount.name=custom-podinfo-${INSTALL_NUMBER},nameOverride=custom-podinfo-app-${INSTALL_NUMBER},fullnameOverride=custom-podinfo-chart-${INSTALL_NUMBER}"
curl http://localhost:8080/custom-podinfo-${INSTALL_NUMBER}

kubectl -n apps port-forward deploy/custom-podinfo-chart-${INSTALL_NUMBER} 8081:9898
open http://0.0.0.0:8081

helm uninstall ${CHART_NAME}-${INSTALL_NUMBER} --namespace apps


curl -H 'User-Agent: Chrome/114.0.0.0' -H 'Accept: text/html,application/xhtml+xml,application/xml' http://localhost:8080/custom-podinfo-1
curl http://localhost:8080/custom-podinfo-2

helm ls --all-namespaces 
kubectl get events -n apps                    
kubectl get pods --all-namespaces 
```

## Resources

* How To Create A Helm Chart [here](https://phoenixnap.com/kb/create-helm-chart)  
* How to set ingress.hosts[0].host in Helm chart via --set command line argument [here](https://stackoverflow.com/questions/68272235/how-to-set-ingress-hosts0-host-in-helm-chart-via-set-command-line-argument)  
* Patch Any Helm Chart Template Using A Kustomize Post-Renderer [here](https://austindewey.com/2020/07/27/patch-any-helm-chart-template-using-a-kustomize-post-renderer/)  