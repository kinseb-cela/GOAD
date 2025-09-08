# https://www.thehacker.recipes/ad/movement/kerberos/delegations/constrained#without-protocol-transition
Set-ADComputer -Identity "financa-srv-2$" -ServicePrincipalNames @{Add='HTTP/financa-dc.financa.pretera.local'}
Set-ADComputer -Identity "financa-srv-2$" -Add @{'msDS-AllowedToDelegateTo'=@('HTTP/financa-dc.financa.pretera.local','HTTP/financa-dc')}
# Set-ADComputer -Identity "financa-srv-2$" -Add @{'msDS-AllowedToDelegateTo'=@('CIFS/financa-dc.financa.pretera.local','CIFS/financa-dc')}