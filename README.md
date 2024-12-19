# Terraform + Azure VSE Subscription Demo

Presentation plus 3 examples, talking about using the Azure Subscription provided with your Visual Studio Enterprise/MSDN license, and using terraform to run infrastructure experiments.

Presentation slides are in the `docs/` folder, and the Marp VSCode extension was used to generate and present them.

## Commands
Command used in this demo, for convienent copy/pasting:
```sh
 infrastructure> terraform init
 infrastructure> terraform plan -var-file="../../env.tfvars"
 infrastructure> terraform apply -var-file="../../env.tfvars"
 > ./deploy.ps1
 infrastructure> terraform destroy -var-file="../../env.tfvars"
```