function Get-EnvTfvars() {
    $tfvars = @{}

    Get-Content "../env.tfvars" | Foreach-Object -Process {
        $match = [Regex]::Match($_, "(\w+) ?= ?\""(.+)\""")

        if ($match.Success) {
            $tfvars[$match.Groups[1].Value] = $match.Groups[2].Value
        }
    }

    return $tfvars
}

$tfvars = Get-EnvTfvars
$appName = "$($tfvars.resource_prefix)1-app"
$subscriptionId = $tfvars.subscription_id

dotnet publish WebApp -o ./WebApp.publish --runtime linux-x64
Compress-Archive -Path "./WebApp.publish/*" -DestinationPath "WebApp.publish.zip" -Force

"Deploying..."
az webapp deploy --src-path "WebApp.publish.zip" --subscription $subscriptionId --resource-group "example-1" --name $appName

