##############################################################
# Simple PoSh-kanboard script                                #
# api_docs: https://kanboard.net/documentation/api-json-rpc  #
# homepage: https://github.com/soulruins/PSKanboard          #
##############################################################
function Get-KanboardProject {
    [CmdletBinding()]
    Param (
    [Parameter (Mandatory=$false, Position=1)]
    [array]$project_id,
    [Parameter (Mandatory=$false, Position=2)]
    [string]$project_name
    )
    ##
    . $PSScriptRoot\pskanboard-conf.ps1
    ##
    $secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
    ##
    if (!$project_id) { $project_id = "" }
    foreach ($i in $project_id) {
    $json = @{
        jsonrpc = "2.0"
        method = "getAllProjects"
        id = "1"
    }
    $json = $json | ConvertTo-Json
    ##
    $res = Invoke-RestMethod -Method Post -Uri $uri -Credential $cred -Body $json -ContentType 'application/json'
    if ($i) {
        $res.result | ? { $_.id -eq $i }
        } elseif ($project_name) {
        $res.result | ? { $_.name -match $project_name }
        }
        else {
        $res.result
        }
    }
}