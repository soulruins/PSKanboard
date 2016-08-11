# PSKanboard
PowerShell module for [Kanboard](https://kanboard.net/) (kanban task manager)
## Features

Work in progress!

* Get list all projects
* Get list all columns
* Get list all tasks
* Create task
* ...
* Support pipeline
* ...

## [COMING SOON] Installation
####[Powershell V5](https://www.microsoft.com/en-us/download/details.aspx?id=50395) and Later
You can install ImportExcel directly from the Powershell Gallery

* [Recommended] Install to your personal Powershell Modules folder
```powershell
Install-Module PSKanboard -scope CurrentUser
```
* [Requires Elevation] Install for Everyone (computer Powershell Modules folder)
```powershell
Install-Module PSKanboard
```

####Powershell V4 and Earlier
To install to your personal modules folder (e.g. ~\Documents\WindowsPowerShell\Modules), run:
```powershell
iex (new-object System.Net.WebClient).DownloadString('https://github.com/soulruins/PSKanboard/blob/master/Install.ps1')
```

## What's new

#### 13/08/2016

* First version

## Examples

List all projects
```powershell
Get-KanboardProject
```
Get project by id
```powershell
Get-KanboardProject -project_id 1
```
Get columns specific project
```powershell
Get-KanboardColumn -project_id 1
# or
Get-KanboardProject -project_id 1 | Get-KanboardColumn
```
Get tasks specific project
```powershell
Get-KanboardTask -project_id 1
# or
Get-KanboardProject -project_id 1 | Get-KanboardTask
```
Get tasks specific project and column
```powershell
Get-KanboardTask -project_id 1 -column_id 1
# or
Get-KanboardProject -project_id 1 | Get-KanboardColumn -column_id 1 | Get-KanboardTask
```

## Tips (powershell)

Format-Table output
```powershell
Get-KanboardProject -project_id 1 | Get-KanboardColumn | Format-Table -Property * -AutoSize
```
Show only name columns
```powershell
Get-KanboardProject -project_id 1 | Get-KanboardColumn | Select-Object -Property name
```

## Known Issues
