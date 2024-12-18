function Get-EnvTfvars() {
    $tfvars = @{}

    Get-Content "env.tfvars" | Foreach-Object -Process {
        $match = [Regex]::Match($_, "(\w+) ?= ?\""(.+)\""")

        if ($match.Success) {
            $tfvars[$match.Groups[1].Value] = $match.Groups[2].Value
        }
    }

    return $tfvars
}

$tfvars = Get-EnvTfvars
$subscriptionId = $tfvars.subscription_id

az provider register --namespace Microsoft.App --subscription $subscriptionId
az provider register --namespace Microsoft.DocumentDB --subscription $subscriptionId
az provider register --namespace Microsoft.KeyVault --subscription $subscriptionId
az provider register --namespace Microsoft.ManagedIdentity --subscription $subscriptionId
az provider register --namespace Microsoft.Storage --subscription $subscriptionId
az provider register --namespace Microsoft.Web --subscription $subscriptionId
