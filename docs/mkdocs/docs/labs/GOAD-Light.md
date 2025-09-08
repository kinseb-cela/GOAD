# GOAD-Light

This is a light version of goad without the siguria domain. This lab was build for computer with less performance (min ~20GB).

![GOAD Light overview](../img/GOAD-Light_schema.png)

Missing scenarios:

- cross forest exploitation (no more external forest)
- mssql trusted link
- some old computer vulnerabilities (zero logon, petitpotam unauthent,...)
- ESC4, ESC2/3

## Servers
This lab is actually composed of five virtual machines:

**domain : pretera.local**

- **pretera-dc1** : DC01  running on Windows Server 2019 (with windefender enabled by default)

**domain : financa.pretera.local**

- **financa-dc**   : DC02  running on Windows Server 2019 (with windefender enabled by default)
- **financa-srv-2**  : SRV02 running on Windows Server 2019 (with windefender **disabled** by default)


## Users/Groups and associated vulnerabilites/scenarios

- You can find a lot of the available scenarios on [https://mayfly277.github.io/categories/ad/](https://mayfly277.github.io/categories/goad/)

**financa.pretera.LOCAL**

- PrtrS:              RDP on financa-dc AND financa-srv-2
    - Anisa.Prtr:        Execute as user on mssql
    - Eduard.Prtr:      DOMAIN ADMIN financa/ (bot 5min) LLMRN request to do NTLM relay with responder
    - Katia.Prtr:     
    - Robert.Prtr:        bot (3min) RESPONDER LLMR
    - Sanja.Prtr:       
    - Brendon.Prtr:     ASREP_ROASTING
    - Riki.Prtr:      
    - theon.greyjoy:
    - jon.Sina:          mssql admin / KERBEROASTING / group cross domain / mssql trusted link
    - hodor:             PASSWORD SPRAY (user=password)
- Specialist Eksport:         RDP on financa-srv-2
    - Samir.Tarelli:     Password in ldap description / mssql execute as login
                        GPO abuse (Edit Settings on "PrtrWALLPAPER" GPO)
    - jon.Sina:          (see Prtrs)
    - Jetar.Importet:      (see Importet)
- Importet:             RDP on financa-srv-2
    - Jetar.Importet:      ACL writedacl-writeowner on group Specialist Eksport
- AcrossTheSea :       cross forest group

**pretera.LOCAL**

- EngineerS
    - Tino.inxhinieri:   ACL forcechangepassword on jani.Engineer
    - jani.inxhinieri:   ACL genericwrite-on-user joan.ekonomisti
    - tritan.inxhinieri:   ACL self-self-membership-on-group Bordi Drejtues
    - cezar.inxhinieri:  DOMAIN ADMIN pretera
- ekonomisti:           RDP on pretera-dc1
    - robert.ekonomisti:  DOMAIN ADMIN pretera
    - joan.ekonomisti: ACL Write DACL on tritan.inxhinieri
    - reni.ekonomisti:
    - shkelqim.ekonomisti: ACL genericall-on-computer pretera-dc1 / ACL writeproperty-self-membership Domain Admins
- Bordi Drejtues :      ACL add Member to group Drejtoria stone / RDP on pretera-dc1
    - petrit.balani:    ACL writeproperty-on-group Domain Admins
    - lord.krasniqi:        ACL genericall-on-group Domain Admins / Acrossthenarrossea
    - mirjan.kastrati:   ACL write owner on group Domain Admins
- Ekzekutivi :        ACL Write Owner on Burimet Njerezore
- Burimet Njerezore :         ACL generic all on user shkelqim.ekonomisti
- AccorsTheNarrowSea:       cross forest group


## Computers Users and group permissions

- pretera
    - DC01 : pretera-dc1.pretera.local (Windows Server 2019) (pretera DC)
        - Admins : robert.ekonomisti (U), cezar.inxhinieri (U)
        - RDP: Bordi Drejtues (G)

- financa
    - DC02 : financa-dc.financa.pretera.local (Windows Server 2019) (financa DC)
        - Admins : Eduard.Prtr (U), Katia.Prtr (U), Robert.Prtr (U)
        - RDP: Prtr(G)

    - SRV02 : financa-srv-2.siguria.local (Windows Server 2019) (IIS, MSSQL, SMB share)
        - Admins: Jetar.Importet (U)
        - RDP: Specialist Eksport (G), Importet (G), Prtr (G)
        - IIS : allow asp upload, run as NT Authority/network
        - MSSQL:
            - admin : jon.Sina
            - impersonate : 
                - execute as login : samwel.tarlly -> sa
                - execute as user : Anisa.Prtr -> dbo
