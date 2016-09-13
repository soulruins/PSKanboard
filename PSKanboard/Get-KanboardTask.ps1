##############################################################
# Simple PoSh-kanboard script                                #
# api_docs: https://kanboard.net/documentation/api-json-rpc  #
# homepage: https://github.com/soulruins/PSKanboard          #
##############################################################
function Get-KanboardTask {
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
        $objects = $objects
        }
    ##
    . $PSScriptRoot\pskanboard-conf.ps1
    ##
    $secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
    ##
    if ($objects.project_id) { $objects = $objects | Sort-Object -Property project_id -Unique }
    foreach ($i in $objects) {
    $json = @{
        jsonrpc = "2.0"
        method = "getAllTasks"
        id = "1"
        params = @{
            "project_id" = $(if (!$i.project_id) {if ($i.id) {$i.id} else {$i}} else {$i.project_id}) #TODO: fix it!
            "status_id" = "1"
        }
    }
    $json = $json | ConvertTo-Json
    ##
    $res = Invoke-RestMethod -Method Post -Uri $uri -Credential $cred -Body $json -ContentType 'application/json'
    $res.result = $res.result | ForEach-Object {
            $_.date_creation = if ($_.date_creation -gt 0) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.date_creation)) } else { "0" }
            $_.date_due = if ($_.date_due -gt 0) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.date_due)) } else { "0" }
            $_.date_modification = if ($_.date_modification -gt 0) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.date_modification)) } else { "0" }
            $_.date_moved = if ($_.date_moved -gt 0) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.date_moved)) } else { "0" }
            $_.date_completed = if ($_.date_completed) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.date_completed)) }
            $_
            }
    if ($column_id) {
        $res.result | ? { $_.column_id -eq $column_id }
        } elseif ($column_title) {
        $res.result | ? { $_.column_title -match $column_title }
        } else {
        $res.result
        }
    }
    }
}