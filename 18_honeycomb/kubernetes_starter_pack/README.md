# HONEYCOMB KUBERNETES STARTER PACK

REF: [terraform_examples/23_honeycomb/README.md](https://github.com/chrisguest75/terraform_examples/blob/master/23_honeycomb/README.md)  

NOTES:

* APIKEY needs permissions to modify columns and create queries.  

## Create Dashboards

```sh
cd kubernetes_starter_pack
set -a
. ./.env
set +a

terraform init

terraform plan --var-file=terraform.tfvars

terraform apply --var-file=terraform.tfvars --auto-approve 
```

## Troubleshooting

```sh
TF_LOG_PROVIDER=debug terraform apply -auto-approve
```

## Resources

* terraform-honeycombio-kubernetes-starter-pack repo [here](https://github.com/honeycombio/terraform-honeycombio-kubernetes-starter-pack)
