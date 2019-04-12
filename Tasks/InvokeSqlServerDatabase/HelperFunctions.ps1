function _Copy {
    param (
        $Path,
        $Destination
    )
    if (-Not (Test-Path -Path $Destination)) {
        Try {
            New-Item -Path $Destination -ItemType Directory -ErrorAction Stop
        }
        Catch {
            throw $_
        }
    }
    Try {
        Copy-Item -Path $Path -Destination $Destination -Recurse -ErrorAction Stop
    }
    Catch {
        Write-Warning "Could not copy $Path to $Destination"
        $_
    }
}

function _Credential {
    param (
        [string]$Username,
        [string]$Password
    )

    $SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
    return New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
}