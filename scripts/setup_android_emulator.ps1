$ErrorActionPreference = 'Stop'
$SDK = 'C:\Users\Advait\AppData\Local\Android\Sdk'
$CTZ = Join-Path $SDK 'cmdline-tools\latest'
New-Item -ItemType Directory -Force -Path $CTZ | Out-Null
$zip = Join-Path $env:TEMP 'cmdline-tools.zip'
Write-Output 'Downloading command-line tools...'
Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-latest.zip' -OutFile $zip
Write-Output 'Extracting...'
Expand-Archive -Path $zip -DestinationPath $CTZ -Force
if (Test-Path (Join-Path $CTZ 'cmdline-tools')) {
    Write-Output 'Rearranging extracted folders...'
    Get-ChildItem -Path (Join-Path $CTZ 'cmdline-tools') | ForEach-Object { Move-Item -Path $_.FullName -Destination $CTZ -Force }
    Remove-Item -Path (Join-Path $CTZ 'cmdline-tools') -Recurse -Force
}
$SM = Join-Path $CTZ 'bin\sdkmanager.bat'
if (-Not (Test-Path $SM)) {
    Write-Error 'sdkmanager not found after extraction'
    Exit 1
}
Write-Output 'Installing SDK packages (this may take a while)...'
& $SM 'platform-tools' 'emulator' 'platforms;android-33' 'system-images;android-33;google_apis;x86_64' --sdk_root=$SDK
Write-Output 'Accepting licenses...'
'y' | & $SM --licenses --sdk_root=$SDK
$AM = Join-Path $CTZ 'bin\avdmanager.bat'
Write-Output 'Creating AVD...'
& $AM create avd -n evstat_avd -k 'system-images;android-33;google_apis;x86_64' --device 'pixel' --force
$EM = Join-Path $SDK 'emulator\emulator.exe'
if (-Not (Test-Path $EM)) {
    Write-Error 'emulator binary not found after install'
    Exit 1
}
Write-Output 'Launching emulator...'
Start-Process -FilePath $EM -ArgumentList '-avd evstat_avd' -NoNewWindow
Write-Output 'Script finished.'
