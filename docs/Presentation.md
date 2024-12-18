---
marp: true
theme: gaia
class:
    - invert
---
# Azure VSE Subscription 
# + Terraform

by Scott Jasperse

https://github.com/sjasperse/TerraformAzureVSESubscriptionDemo/

---
## Azure VSE Subscription

- Provided via your Visual Studio Enterprise/MSDN license 
- Set up at https://my.visualstudio.com
- $150/mo. credit with a hard stop. No way to get in trouble for over-use
- Full administrator
- Part of company tenant - so you can grant coworkers permission to your stuff


---
## Terraform
![bg h:450 right:40%](example-1.png)

- Built by HashiCorp
- Many "Providers"
  - Azure, AWS, GCP, DigitalOcean, Kubernetes...
- Is not a "one configuration, multiple cloud" solution.
- Azurerm provider is built on top of Azure's ARM json templates.

---
## Terraform - Why?

- Infrastructure-as-Code
  - Version trackable, repeatable, auditable
- Keep track of a working environment, without needing to keep the resources around.
- Can create, and destroy on demand.
- Use infrastructure to control configuration, so you don't have to configure it manually.
- I find it a good way to learn how resources work and how they fit together.

---
## Terraform - Why?
![bg right](power-aladdin.png)


- Feel the god-like powers flow through your terminal.


---
## Before we get started....

- Create a `env.tfvars` file in the root of your repo.
- Scripts are in powershell. 
  - You may need to run `Set-ExecutionPolicy Unrestricted` from an administrative session.
- You will probably need to enable "Resource providers" in your Azure Subscription. 
  - `./Register-Providers.ps1` may help
- I tested all this on a mac, but I tried to make everything cross-platform.
 

---
## Example 1

Simple example for a hello world app deployed to Azure.

Nearly entirely copy/pasted from: [azurerm: example-usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#example-usage), [azurerm: linux_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app), [random: password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)

Commands I will be using:
```sh
 infrastructure> terraform init
 infrastructure> terraform plan -var-file="../../env.tfvars"
 infrastructure> terraform apply -var-file="../../env.tfvars"
 > ./deploy.ps1
 infrastructure> terraform destroy -var-file="../../env.tfvars"
```


---
## Terraform - State

- Lets look at `terraform.tfstate`
  - Terraform's master copy of what it knows and manages. Needs to be only one copy.
  - Contains sensitive data - so needs to stay out of version control. 
- State storage options:
  - Check out https://developer.hashicorp.com/terraform/language/backend


---
## Example 2

Simple web app, connected to Cosmos, using Key Vault, and User-Managed Identity for Key Vault and Cosmos access.

Commands I will be using:
```sh
 infrastructure> terraform init
 infrastructure> terraform plan -var-file="../../env.tfvars"
 infrastructure> terraform apply -var-file="../../env.tfvars"
 > ./deploy.ps1
 infrastructure> terraform destroy -var-file="../../env.tfvars"
```


----
## Example 3

Simple web app infrastructure, deployed to 2 regions using a reusable module, and a shared app insights.

Commands I will be using:
```sh
 infrastructure> terraform init
 infrastructure> terraform plan -var-file="../../env.tfvars"
 infrastructure> terraform apply -var-file="../../env.tfvars"
 > ./deploy.ps1
 infrastructure> terraform destroy -var-file="../../env.tfvars"
```


---
## Azure Subscription - Cost Analysis

![h:500](cost-analysis.png)

