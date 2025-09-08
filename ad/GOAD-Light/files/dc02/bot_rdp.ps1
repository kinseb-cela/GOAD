# https://learn.microsoft.com/fr-fr/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon
if(-not(query session Robert.Prtr /server:financa-srv-2)) {
  #kill process if exist
  Get-Process mstsc -IncludeUserName | Where {$_.UserName -eq "financa\Robert.Prtr"}|Stop-Process
  #run the command
  mstsc /v:financa-srv-2
}