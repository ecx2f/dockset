# dockset

Minimal PowerShell automation to install **Docker Desktop on Windows (WSL2)** with **custom install + data-root paths** so Docker/WSL data can live on a secondary drive.

## What it does
- Runs the Docker Desktop installer with:
  - custom app install directory
  - custom WSL2 data root
  - custom Windows containers data root
- Auto-elevates to Administrator if needed

## Quick start
1. Download the Docker Desktop installer from [Docker Desktop](https://www.docker.com/products/docker-desktop/).
2. Put the installer next to this script as `Docker Desktop Installer.exe`.
3. Run:

```powershell
.\install-docker.ps1
```

## Customize paths

```powershell
.\install-docker.ps1 `
  -InstallDir "D:\Dev Program Files\Docker\App" `
  -WslDataRoot "D:\Dev Program Files\Docker\wsl" `
  -WindowsContainersDataRoot "D:\Dev Program Files\Docker\windows"
```

## Requirements
- Windows 10/11
- WSL 2 enabled

## Author
ecx2f

## License
MIT. See `LICENSE`.
