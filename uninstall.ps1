#Requires -Version 6

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet('Default', 'Flat', 'Mini')]
    [string] $Layout = 'Default',
    [Parameter()]
    [switch] $PreRelease
)

# Based on @nerdio01's version in https://github.com/microsoft/terminal/issues/1060

if ((Test-Path "Registry::HKEY_CURRENT_USER\Directory\shell\MenuTerminal") -and
    -not (Test-Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\MenuTerminal")) {
    Write-Error "Please execute uninstall.old.ps1 to remove previous installation."
    exit 1
}

$localCache = "$Env:LOCALAPPDATA\Microsoft\WindowsApps\Cache"
if (Test-Path $localCache) {
    Remove-Item $localCache -Recurse
}

Write-Host "Use" $layout "layout."

if ($layout -eq "default") {
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\Background\shell\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\ContextMenus\MenuTerminal\shell' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\Background\shell\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\ContextMenus\MenuTerminalAdmin\shell' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\shell\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\ContextMenus\MenuTerminal\shell' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\shell\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\ContextMenus\MenuTerminalAdmin\shell' -Recurse -ErrorAction Ignore | Out-Null
} elseif ($layout -eq "flat") {
    $rootKey = 'HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\MenuTerminal_*") -or ($key.Name -like "$rootKey\MenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

    $rootKey = 'HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\Background\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\MenuTerminal_*") -or ($key.Name -like "$rootKey\MenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

    $rootKey = 'HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\MenuTerminal_*") -or ($key.Name -like "$rootKey\MenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

} elseif ($layout -eq "mini") {
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\MenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\MenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\Background\shell\MenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\Background\shell\MenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\shell\MenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Classes\Drive\shell\MenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
}

Write-Host "Windows Terminal uninstalled from Windows Explorer context menu."
