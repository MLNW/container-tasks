param (
  [string]$vhdxPath
)

# Normalize the VHDX path to a standard format, stripping off any PowerShell path prefix
function Normalize-PathFormat($path) {
  $normalizedPath = [System.IO.Path]::GetFullPath($path)
  $normalizedPath = $normalizedPath -replace '^\\\\\?\\', ''
  $normalizedPath = $normalizedPath + '\ext4.vhdx'
  return $normalizedPath
}

# Resolve the input path to an absolute path
$vhdxPath = (Resolve-Path $vhdxPath).Path

$lxssRegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss"

$result = @{ 'Found' = $false; 'DistroName' = $null }

# Check if the LXSS path exists in the registry
if (Test-Path $lxssRegPath) {
  # Get all subkeys, which represent the installed WSL distributions
  $distroKeys = Get-ChildItem $lxssRegPath

  foreach ($key in $distroKeys) {
    # Try to get the BasePath for each distribution and handle potential errors
    $basePath = $null
    try {
      $basePath = (Get-ItemProperty -Path $key.PSPath -ErrorAction Stop).BasePath
      $normalizedBasePath = Normalize-PathFormat $basePath
    } catch {
      continue
    }

    # Compare BasePath with the provided VHDX path
    if ($normalizedBasePath -eq $vhdxPath) {
      $distroName = (Get-ItemProperty -Path $key.PSPath).DistributionName
      $result.Found = $true
      $result.DistroName = $distroName
      break
    }
  }
}

return $result
