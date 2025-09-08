Set-ADUser -Identity "jon.Sina" -ServicePrincipalNames @{Add='CIFS/thewall.financa.pretera.local'}
Get-ADUser -Identity "jon.Sina" | Set-ADAccountControl -TrustedToAuthForDelegation $true
Set-ADUser -Identity "jon.Sina" -Add @{'msDS-AllowedToDelegateTo'=@('CIFS/financa-dc.financa.pretera.local','CIFS/financa-dc')}