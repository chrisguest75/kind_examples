# HONEYCOMB KUBERNETES STARTER PACK

REF: [terraform_examples/23_honeycomb/README.md](https://github.com/chrisguest75/terraform_examples/blob/master/23_honeycomb/README.md)  

NOTES:

* APIKEY needs permissions to modify columns and create queries.  
* These dashboards do not work with the OTEL collector.  

## Create Dashboards

```sh
cd kubernetes_starter_pack
set -a
. ./.env
set +a

# download modules and initialise
terraform init

# plan resources
terraform plan --var-file=terraform.tfvars

# create resoures
terraform apply --var-file=terraform.tfvars --auto-approve 
```

## Troubleshooting

```sh
TF_LOG_PROVIDER=debug terraform apply -auto-approve
```

## Cleanup

```sh
# delete resources
terraform destory --var-file=terraform.tfvars 
```

## Resources

* terraform-honeycombio-kubernetes-starter-pack repo [here](https://github.com/honeycombio/terraform-honeycombio-kubernetes-starter-pack)
