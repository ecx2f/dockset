param(
    [string]$InstallerPath = (Join-Path $PSScriptRoot "Docker Desktop Installer.exe"),
    [string]$InstallDir = "D:\Dev Program Files\Docker\App",
    [string]$WslDataRoot = "D:\Dev Program Files\Docker\wsl",
    [string]$WindowsContainersDataRoot = "D:\Dev Program Files\Docker\windows"
)

# Check if the script is running with admin privileges
$Elevated = [System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()
$IsAdmin = $Elevated.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

# If not running as Administrator, restart the script as Administrator
if (-not $IsAdmin) {
    Write-Host "This script requires administrator privileges. Restarting as administrator..."
    $RelaunchArgs = @(
        "-NoProfile"
        "-ExecutionPolicy"
        "Bypass"
        "-File"
        "`"$PSCommandPath`""
    )

    foreach ($Entry in $PSBoundParameters.GetEnumerator()) {
        $Name = $Entry.Key
        $Value = $Entry.Value

        if ($Value -is [System.Management.Automation.SwitchParameter]) {
            if ($Value.IsPresent) { $RelaunchArgs += "-$Name" }
        }
        else {
            $RelaunchArgs += "-$Name"
            $RelaunchArgs += "`"$Value`""
        }
    }

    Start-Process -FilePath "powershell" -ArgumentList $RelaunchArgs -Verb RunAs
    exit
}

if (-not (Test-Path -Path $InstallerPath -PathType Leaf)) {
    Write-Error "Installer not found: $InstallerPath`nPlace 'Docker Desktop Installer.exe' next to this script, or pass -InstallerPath."
    exit 2
}

$ArgumentList = @(
    "install"
    "-accept-license"
    "--installation-dir=`"$InstallDir`""
    "--wsl-default-data-root=`"$WslDataRoot`""
    "--windows-containers-default-data-root=`"$WindowsContainersDataRoot`""
)

# If running as Administrator, proceed with the Docker installation
Start-Process -Wait -FilePath $InstallerPath -ArgumentList $ArgumentList
