# install_docker.ps1

Write-Host "Installation de Docker Desktop et Docker Compose..."

# Vérifier que le script est exécuté en tant qu'administrateur
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Ce script doit être exécuté en tant qu'administrateur."
    Exit
}

# Activer Hyper-V (requis pour Docker)
Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All -NoRestart

# Télécharger Docker Desktop (Windows)
$installerPath = "$env:TEMP\DockerDesktopInstaller.exe"
Invoke-WebRequest -Uri "https://desktop.docker.com/win/main/amd64/Docker Desktop Installer.exe" -OutFile $installerPath

# Installer Docker Desktop silencieusement
Start-Process -FilePath $installerPath -ArgumentList "install", "--quiet" -Wait

# Ajouter Docker au PATH (si nécessaire)
$dockerPath = "$Env:ProgramFiles\Docker\Docker\resources\bin"
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    [Environment]::SetEnvironmentVariable("Path", $Env:Path + ";$dockerPath", [System.EnvironmentVariableTarget]::Machine)
}

# Vérifier l'installation
docker --version
docker-compose version

Write-Host "Docker et Docker Compose ont été installés avec succès."

