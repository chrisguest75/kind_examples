# USING GITLAB

NOTE:

* Whilst working the bootstrap out I've been deleting and recreating the cluster.  
* Be careful of the username and email on the bootstrap command. If you have gitlab set to reject non-org email domains it will fail confusingly.  

## Clusters

Create a versioned single node cluster.  

```sh
kind create cluster --config 1node_1_27_cluster.yaml --name kind-1-27
```

## Install

```sh
# check your connection
kubectx

# source GITHUB_TOKEN
. ./.env

# deploy token auth
flux bootstrap gitlab \
  --hostname=gitlab.me.com \
  --deploy-token-auth \
  --owner=org/groups \
  --repository=cg_fluxv2_deployments \
  --branch=main \
  --path=clusters/kind-kind-1-27

# token auth
flux bootstrap gitlab \
  --hostname=gitlab.me.com \
  --token-auth=false \
  --owner=org/groups \
  --repository=cg_fluxv2_deployments \
  --branch=main \
  --path=clusters/kind-kind-1-27

# deploy keys...
ssh-keygen -o -a 100 -t ed25519 -C "gitlab deploy key" -f ./keys/id_ed25519 

# ensure you set the author email and name if you have restrictions (otherwise you'll get a confusing failure to push)
flux bootstrap --verbose --log-level debug --author-email "forename.surname@myemail.com" --author-name "Me" git \
  --url="ssh://git@gitlab.me.com/org/groups/cg_fluxv2_deployments.git" \
  --branch=main \
  --private-key-file=./keys/id_ed25519 \
  --path=clusters/kind-kind-1-27

# open k9s
k9s
```

## Resources

* Get Started with Flux [here](https://fluxcd.io/flux/get-started/)
* fluxcd/flux2 [here](https://github.com/fluxcd/flux2)
* https://fluxcd.io/flux/installation/bootstrap/gitlab/#gitlab-deploy-keys
* https://docs.gitlab.com/ee/user/project/deploy_tokens/
* https://docs.gitlab.com/ee/user/project/settings/project_access_tokens.html
* https://docs.gitlab.com/ee/user/ssh.html