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
