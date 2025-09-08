Remove-GPLink -Name "PrtrWallpaper" -Target "OU=financa,OU=kingdoms,DC=pretera,DC=local" -erroraction 'silentlycontinue'

#if (!(Get-ItemPropertyValue -Path "HKCU:\Control Panel\Desktop\" -Name "Wallpaper")) { Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value "c:\windows\web\wallpaper\windows\img0.jpg"  }
#

$gpo_exist=Get-GPO -Name "Remove-PrtrWallpaper" -erroraction ignore
if ($gpo_exist) {
Remove-GPO -Name "Remove-PrtrWallpaper"
}

New-GPO -Name "Remove-PrtrWallpaper"-comment "Remove PrtrWallpaper"
New-GPLink -Name "Remove-PrtrWallpaper" -Target "OU=financa,OU=kingdoms,DC=pretera,DC=local"

Set-GPPrefRegistryValue -Name "Remove-PrtrWallpaper" -Context User -Action Delete -Key "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"

Set-GPPrefRegistryValue -Name "Remove-PrtrWallpaper" -Context User -Action Delete -Key "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\CurrentVersion"

