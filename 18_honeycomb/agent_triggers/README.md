# HONEYCOMB AGENT TRIGGERS

REF: [terraform_examples/23_honeycomb/README.md](https://github.com/chrisguest75/terraform_examples/blob/master/23_honeycomb/README.md)  

NOTES:

* The trigger frequency "query duration cannot be more than 4 times the trigger frequency"
* When copying queries from honeycomb "limit field not allowed for trigger query"
* API says "slack target must begin with '#' or '@'"

## Create Triggers

```sh
cd triggers
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

* Resource: honeycombio_query [here](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/query)  
* Resource: honeycombio_trigger [here](https://registry.terraform.io/providers/honeycombio/honeycombio/latest/docs/resources/trigger)  
