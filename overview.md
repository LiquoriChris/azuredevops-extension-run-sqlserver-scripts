# Run SQL Server Database Scripts

Executes SQL Server database scripts using the dbatools PowerShell module.

## Details

Task can run multiple database scripts during a release.

## How it works

Task will look for .sql files in a specified directory to run Invoke-DbaQuery against a database. Options can be added to the sql file to enhance functionality of the script.

## Installation

Add the "DbaTools Module Installer" task above the "Run SQLServer Database Scripts" task. This will install the module scoped to the current user, and can be installed on hosted as well as self-hosted agents.

Add a user capability to the agent pool: 
Name: dbatools
Value: C:\Program Files\WindowsPowerShell\Modules\dbatools

## Note

dbatools module must be available before running this task.

Run Pester test located under "Tests" folder to verify the dbatools module is installed. 