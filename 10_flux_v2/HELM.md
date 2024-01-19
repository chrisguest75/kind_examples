# Adding Helm Charts

You've built a cluster following [README.md](./README.md)  

[17_podinfo/README.md](../17_podinfo/README.md)

TODO:

* THIS IS NOT WORKING CORRECTLY

## Add Helm

In the deployment repo run.  

```sh
# add the source
flux create source helm podinfo \
--namespace=default \
--url=https://stefanprodan.github.io/podinfo \
--interval=10m

# Create a HelmRelease targeting another namespace than the resource

cat > ./clusters/kind-kind-1-27/podinfo-helm-values.yaml <<EOL
replicaCount: 2
resources:
  limits:
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 64Mi
EOL

# the values get rendered in the export file
# default is the namespace of helm.
flux create helmrelease podinfo \
    --namespace=default \
    --interval=30s \
    --target-namespace=test-helm-podinfo \
    --create-target-namespace=true \
    --source=HelmRepository/podinfo \
    --release-name=podinfo \
    --chart=podinfo \
    --chart-version=">5.0.0" \
    --values=./clusters/kind-kind-1-27/podinfo-helm-values.yaml \
    --export > ./clusters/kind-kind-1-27/podinfo-helm.yaml

# commit and sync
git add -A && git commit -m "Add podinfo Helm to GitRepository"
git push
```

## Check helm releases

```sh
# it installs a sources "failed to get source: HelmRepository.source.toolkit.fluxcd.io "podinfo" not found"
flux get sources all -A


flux get helmreleases -n default
```

## Resources

* https://fluxcd.io/flux/cmd/flux_create_helmrelease/
* https://github.com/stefanprodan/podinfo?tab=readme-ov-file#continuous-delivery
* https://github.com/fluxcd/flux2/discussions/1631