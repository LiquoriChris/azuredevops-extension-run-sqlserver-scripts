[CmdletBinding()]
param ()

$Version = Get-VstsInput -Name version

Try {
    Get-PackageProvider -Name NuGet -ErrorAction Stop |Out-Null
}
Catch {
    $Params.Scope = 'CurrentUser'
    Install-PackageProvider @Params
}

$Params = @{
    Name = 'dbatools'
    Force = $true
    Scope = 'CurrentUser'
    ErrorAction = 'Stop'
}

Try {
    if ($Version -eq 'specificVersion') {
        $SpecificVersion = Get-VstsInput -Name dbaToolsVersion
        $Params.RequiredVersion = $SpecificVersion
    }
    else {
        $Latest = Find-Module -Name dbatools |Select-Object -ExpandProperty Version
        $Params.RequiredVersion = $Latest
    }
    $Params.Remove('Scope')
    $Params.Remove('Force')
    Get-InstalledModule @Params
}
Catch {
    Try {
        if ($Version -eq 'specificVersion') {
            $Params.RequiredVersion = $SpecificVersion
        }
        $Params.Scope = 'CurrentUser'
        $Params.Force = $true
        Install-Module @Params
    }
    Catch {
        throw $_
    }
}