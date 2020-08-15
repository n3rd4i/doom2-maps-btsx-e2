$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$url        = 'http://esselfortium.net/wasd/btsx_e2.zip'
$unzipLocation = "$(Join-Path $toolsDir wad)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $unzipLocation
  url           = $url
  checksum      = '1BC72E790AA5438AE3E7B51C3578CDE4A2007B14B69337DA75848996C686C7AB'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs


# Cleanup link first (safely)
& $ENV:COMSPEC /C IF EXIST $wad1_lnk DEL /S /Q $wad1_lnk
& $ENV:COMSPEC /C IF EXIST $wad2_lnk DEL /S /Q $wad2_lnk

# Install symbolic link for later use
& $ENV:COMSPEC /C MKLINK $wad1_lnk "$(Join-Path $unzipLocation $wad1)"
& $ENV:COMSPEC /C MKLINK $wad2_lnk "$(Join-Path $unzipLocation $wad2)"
