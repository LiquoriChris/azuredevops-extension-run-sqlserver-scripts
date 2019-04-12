[CmdletBinding()]
param ()

$Version = Get-VstsInput -Name version

$Params = @{
    Name = 'dbatools'
    Force = $true
    Scope = 'CurrentUser'
    ErrorAction = 'Stop'
}

Install-PackageProvider -Name NuGet -Force:$Params.Force -Scope $Params.Scope

if ($Version -eq 'specificVersion') {
    $SpecificVersion = Get-VstsInput -Name dbaToolsVersion
    $Params.RequiredVersion = $SpecificVersion
}

Try {
    Get-InstalledModule -Name dbatools -ErrorAction Stop
}
Catch {
    Try {
        Install-Module @Params
    }
    Catch {
        throw $_
    }
}

