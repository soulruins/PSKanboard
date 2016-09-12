# PSKanboard
PowerShell module for [Kanboard](https://kanboard.net/) (kanban task manager)

![pic](http://i.imgur.com/vrTWxND.png)

## Features

Work in progress!

- [x] Get list all projects
- [x] Get list all columns
- [x] Get list all tasks
- [ ] Create task (**soon**)
- [x] Support pipeline
- [ ] More soon


##  Installation

1. Download
2. Copy `PSKanboard` to your [modules folder](https://msdn.microsoft.com/en-us/library/dd878350(v=vs.85).aspx) (e.g. `$Home\Documents\WindowsPowerShell\PSKanboard`)
3. Execute `Import-Module PSKanboard` (or add this to your profile)
4. Enjoy!

### FAQ

By default, PowerShell restricts execution of all scripts. This is all about security. To "fix" this run PowerShell as Administrator and call
```powershell
Set-ExecutionPolicy RemoteSigned
```
For mode details run get-help about_signing or get-help about_Execution_Policies.

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
