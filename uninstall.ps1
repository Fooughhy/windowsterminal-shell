# Based on @nerdio01's version in https://github.com/microsoft/terminal/issues/1060

$localCache = "$Env:LOCALAPPDATA\Microsoft\WindowsApps\Cache"
if (Test-Path $localCache) {
    Remove-Item $localCache -Recurse
}

if ($args.Count -eq 1) {
    $layout = $args[0]
} else {
    $layout = "default"
}

Write-Host "Use" $layout "layout."

if ($layout -eq "default") {
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    #Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuTerminal\shell' -Recurse -ErrorAction Ignore | Out-Null

    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    #Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuTerminalAdmin\shell' -Recurse -ErrorAction Ignore | Out-Null

    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\shell\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    #Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\ContextMenus\MenuTerminal\shell' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\shell\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
    #Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\ContextMenus\MenuTerminalAdmin\shell' -Recurse -ErrorAction Ignore | Out-Null

    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\ContextMenus\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\ContextMenus\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null

    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\ContextMenus\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null

    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuTerminal' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\ContextMenus\MenuTerminalAdmin' -Recurse -ErrorAction Ignore | Out-Null
} elseif ($layout -eq "flat") {
    $rootKey = 'HKEY_CLASSES_ROOT\Directory\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\MenuTerminal_*") -or ($key.Name -like "$rootKey\MenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

    $rootKey = 'HKEY_CLASSES_ROOT\Directory\Background\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\MenuTerminal_*") -or ($key.Name -like "$rootKey\MenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

    $rootKey = 'HKEY_CLASSES_ROOT\Drive\shell'
    foreach ($key in Get-ChildItem -Path "Registry::$rootKey") {
       if (($key.Name -like "$rootKey\MenuTerminal_*") -or ($key.Name -like "$rootKey\MenuTerminalAdmin_*")) {
          Remove-Item "Registry::$key" -Recurse -ErrorAction Ignore | Out-Null
       }
    }

} elseif ($layout -eq "mini") {
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\MenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\shell\MenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\MenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\MenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\shell\MenuTerminalMini' -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path 'Registry::HKEY_CLASSES_ROOT\Drive\shell\MenuTerminalAdminMini' -Recurse -ErrorAction Ignore | Out-Null
}

Write-Host "Windows Terminal uninstalled from Windows Explorer context menu."
