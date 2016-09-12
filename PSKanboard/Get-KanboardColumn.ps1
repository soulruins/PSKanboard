##############################################################
# Simple PoSh-kanboard script                                #
# api_docs: https://kanboard.net/documentation/api-json-rpc  #
# homepage: https://github.com/soulruins/PSKanboard          #
##############################################################
function Get-KanboardColumn {
    [CmdletBinding()]
    Param (
    [Parameter (Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    $project_id,
    [Parameter (Mandatory=$false, Position=2)]
    [int]$column_id,
    [Parameter (Mandatory=$false, Position=3)]
    [string]$column_title
    )
    ##
    begin { $objects = @() }
    process { $objects += $project_id }
    end {
    if ($objects.id) {
        $objects = $objects.id
        }
    ##
    . $PSScriptRoot\pskanboard-conf.ps1
    ##
    $secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
    ##
    foreach ($i in $objects) {
    $json = @{
        jsonrpc = "2.0"
        method = "getColumns"
        id = "1"
        params = @{
            "project_id" = $i
        }
    }
    $json = $json | ConvertTo-Json
    ##
    $res = Invoke-RestMethod -Method Post -Uri $uri -Credential $cred -Body $json -ContentType 'application/json'
    $res.result
    }
    }
}