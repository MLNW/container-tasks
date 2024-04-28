# This installer imports a .tar packaged WSL distro on a Windows host with WSL
# installed. It should be delivered together with a .tar file.

$WorkingDir = Convert-Path .
$HardDriveFile = "$WorkingDir\ext4.vhdx"

# You may want to change the name yourself
$WslDistroName = "<name>"
# This must be the path to the .tar file containing the exported filesystem for import
$WslTar = "<tar>"

# Check no distro with this name exists
if ($(wsl -l) -Contains $WslDistroName) {
  $Title    = "A WSL installation with the name '$WslDistroName' already exists"
  $Question = 'To continue we need to remove this distro, thereby deleting all of its data. Do you want to continue?'
  $Choices  = '&Yes', '&No'

  $decision = $Host.UI.PromptForChoice($Title, $Question, $Choices, 1)
  if ($decision -eq 0) {
    wsl --unregister $WslDistroName
  }
  else {
    exit
  }
}

# Check the working directory for another ext4.vhdx file
if ([System.IO.File]::Exists($HardDriveFile)) {
  $FindDistroResult = & ($PSScriptRoot + "\find-wsl-distro.ps1") $HardDriveFile

  if ($FindDistroResult.Found) {
    throw New-Object System.Exception("This directory already contains a 'ext4.vhdx' file.
      It belongs to the '$($FindDistroResult.DistroName)' WSL distro.
      Either unregister this distro via
        wsl --unregister $($FindDistroResult.DistroName)
      or import the new distro in a new folder.")
  } else {
    throw New-Object System.Exception("This directory already contains a 'ext4.vhdx' file.
      We were unable to figure out to which WSL distro it belongs.
      It may be orphaned or it could belong to another user.
      You may want to delete it, which may lead to data loss, or you may simply want to import the new distro in a nother folder.")
  }
}

Write-Host "Importing WSL instance: $WslDistroName"
wsl --import $WslDistroName . $WslTar --version 2

if (!$?) {
  throw New-Object System.Exception("The import command has failed.
    Please have take a look what it was and resolve it before running the import again.")
} else {
  Write-Host 'Import successful'
}

$configureGit = Read-Host "Do you want to configure Git name and email? (yes/no)"
if ($configureGit -eq 'yes') {
  $userName = Read-Host "Enter your name, e.g., Max Mustermann"
  $userEmail = Read-Host "Enter your email, e.g., max.mustermann@mail.domain"

  Write-Host "Configuring Git user and email: $userName <$userEmail>"
  wsl -d $WslDistroName git config --global user.name "$userName"
  wsl -d $WslDistroName git config --global user.email "$userEmail"
} else {
  Write-Host "Git configuration skipped."
}

$WindowsHome = $env:userprofile -replace '\\', '/'
$WindowsSshFolder = "$WindowsHome/.ssh"
if (Test-Path -Path $WindowsSshFolder) {
  Write-Host "Importing SSH key from $WindowsSshFolder"
  $WindowsSshFolderLinuxPath = $(wsl -d $WslDistroName wslpath -u $WindowsSshFolder)
  wsl -d $WslDistroName mkdir -p ~/.ssh
  wsl -d $WslDistroName cp $WindowsSshFolderLinuxPath/id_rsa* ~/.ssh/.
  wsl -d $WslDistroName chmod 600 ~/.ssh/id_rsa
  wsl -d $WslDistroName chmod 644 ~/.ssh/id_rsa.pub
}

wsl --terminate $WslDistroName

Write-Host "WSL distro installation complete."
Write-Host ""
Write-Host "You may start the instance via"
Write-Host ""
Write-Host "  wsl -d $WslDistroName"
Write-Host ""

Write-Host "If you set the WSL distro as your default via"
Write-Host ""
Write-Host "  wsl --set-default $WslDistroName"
Write-Host ""
Write-Host "then you can simply run it via"
Write-Host ""
Write-Host "  wsl"
Write-Host ""
