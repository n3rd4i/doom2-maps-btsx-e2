$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$url        = 'http://static.angryscience.net/doom/btsx_e2_b1.zip'
$unzipLocation = "$(Join-Path $toolsDir wad)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $unzipLocation
  url           = $url
  checksum      = '4431E3D377E526D7580322072F0E7D37273770BDE398FD2F036A0068B0D93A95'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# Cleanup link first (safely)
& $ENV:COMSPEC /C IF EXIST $wad1_lnk DEL /S /Q $wad1_lnk
& $ENV:COMSPEC /C IF EXIST $wad2_lnk DEL /S /Q $wad2_lnk

# Install symbolic link for later use
& $ENV:COMSPEC /C MKLINK $wad1_lnk "$(Join-Path $unzipLocation $wad1)"
& $ENV:COMSPEC /C MKLINK $wad2_lnk "$(Join-Path $unzipLocation $wad2)"
