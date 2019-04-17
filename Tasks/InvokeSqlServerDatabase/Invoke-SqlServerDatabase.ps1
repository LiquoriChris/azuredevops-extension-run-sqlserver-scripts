[CmdletBinding()]
param ()

$ScriptPath = Get-VstsInput -Name 'scriptPath' -Require
$User = Get-VstsInput -Name 'user' -Require
$Password = Get-VstsInput -Name 'password' -Require
$DatabaseName = Get-VstsInput -Name 'databaseName' -Require
$SqlInstance = Get-VstsInput -Name 'sqlInstance' -Require
$LogPath = Get-VstsInput -Name 'logPath'
$Copy = Get-VstsInput -Name 'copy'

. $PSScriptRoot\HelperFunctions.ps1

$SqlPath = Find-VstsFiles -LiteralDirectory $ScriptPath -LegacyPattern **.sql
if ($SqlPath) {
    $Credential = _Credential -Username $User -Password $Password
    foreach ($SqlFile in $SqlPath) {	
        $Params = @{
            File = $SqlFile
            SqlInstance = $SqlInstance
            Database = $DatabaseName
            SqlCredential = $Credential
            EnableException = $true
            AppendServerInstance = $true
            ErrorAction = 'Stop'
        }
        Try {
            if ($LogPath) {
                $SqlFileName = (Get-ChildItem -Path $SqlFile).Name
                Invoke-DbaQuery @Params |Tee-Object -LiteralPath "$LogPath\$($SqlFileName).log"
                if ($Copy -eq 'true') {
                    _Copy -Path $SqlFile -Destination $LogPath
                }
            }
            else {
                Invoke-DbaQuery @Params
            }
        }
        Catch {
            throw $_ 
        }
    }
}
else {
    return "No sql files exist at $ScriptPath"
}