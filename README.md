
## Command pallet:
```sh
 PS> Set-ExecutionPolicy Unrestricted
 PS> ./Register-Providers.ps1
 PS infrastructure> terraform init
 PS infrastructure> terraform apply -var-file="../../env.tfvars"
 PS> ./deploy.ps1
```