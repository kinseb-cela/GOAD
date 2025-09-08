# GOAD-Mini

This is a minimalist version of goad with only pretera.lab domain. This lab was build for a minimalist base to do test and try extensions.

![goad_mini.png](../img/goad_mini.png)

## Servers
**domain : pretera.local**
- **pretera-dc1** : DC01  running on Windows Server 2019 (with windefender enabled by default)

## Users/Groups and associated vulnerabilites/scenarios

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
