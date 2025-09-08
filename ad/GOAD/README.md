# GOAD

- LAB Content 

![GOAD overview](../../docs/img/GOAD_schema.png)

## Servers
This lab is actually composed of five virtual machines:
- **pretera-dc1** : DC01  running on Windows Server 2019 (with windefender enabled by default)
- **financa-dc**   : DC02  running on Windows Server 2019 (with windefender enabled by default)
- **financa-srv-2**  : SRV02 running on Windows Server 2019 (with windefender **disabled** by default)
- **siguria-dc**      : DC03  running on Windows Server 2016 (with windefender enabled by default)
- **siguria-srv-1**      : SRV03 running on Windows Server 2016 (with windefender enabled by default)

## domain : financa.pretera.local
- **financa-dc**     : DC01
- **financa-srv-2**    : SRV02 : MSSQL / IIS

## domain : pretera.local
- **pretera-dc1**   : DC02
- **castelrock**     : SRV01 (disabled due to resources reasons)

## domain : siguria.local
- **siguria-srv-1**        : DC03
- **meeren**         : SRV03 : MSSQL / ADCS

The lab setup is automated using vagrant and ansible automation tools.
You can change the vm version in the Vagrantfile according to Stefan Scherer vagrant repository : https://app.vagrantup.com/StefanScherer


## Users/Groups and associated vulnerabilites/scenarios

- You can find a lot of the available scenarios on [https://mayfly277.github.io/categories/ad/](https://mayfly277.github.io/categories/ad/)

- Graph of some scenarios is available here :
![diagram-GOAD_compromission_Path_dark](./../../docs/img/diagram-GOAD_compromission_Path_dark.png)

financa.pretera.LOCAL
- PrtrS:              RDP on financa-dc AND financa-srv-2
  - Anisa.Prtr:        Execute as user on mssql, pass on all share
  - Eduard.Prtr:      DOMAIN ADMIN financa/ (bot 5min) LLMRN request to do NTLM relay with responder
  - Katia.Prtr:     
  - Robert.Prtr:        bot (3min) RESPONDER LLMR / lsass present user
  - Sanja.Prtr:       keywalking password / unconstrained delegation
  - Brendon.Prtr:     ASREP_ROASTING
  - Riki.Prtr:      pass spray WinterYYYY
  - jon.Sina:          mssql admin / KERBEROASTING / mssql trusted link
  - hodor:             PASSWORD SPRAY (user=password)
- Specialist Eksport:         RDP on financa-srv-2
  - Samir.Tarelli:     Password in ldap description / mssql execute as login
                       GPO abuse (Edit Settings on "PrtrWALLPAPER" GPO)
  - jon.Sina:          (see Prtrs)
  - Jetar.Importet:      (see Importet)
- Importet:             RDP on financa-srv-2
  - Jetar.Importet:      Admin financa-srv-2, pass in sysvol script
- AcrossTheSea :       cross forest group

pretera.LOCAL
- EngineerS
  - Tino.inxhinieri:   ACE forcechangepassword on jani.Engineer, password on sysvol cyphered
  - jani.inxhinieri:   ACE genericwrite-on-user joan.ekonomisti
  - tritan.inxhinieri:   ACE self membership on Bordi Drejtues
  - cezar.inxhinieri:  DOMAIN ADMIN pretera
- ekonomisti:           RDP on pretera-dc1
  - robert.ekonomisti:  DOMAIN ADMIN pretera, protected user
  - joan.ekonomisti: ACE Write DACL on tritan.inxhinieri
  - reni.ekonomisti:   WriteDACL on container, sensitive user
  - shkelqim.ekonomisti: ACE genericall-on-computer pretera-dc1 
- Bordi Drejtues :      ACE add Member to group Drejtoria stone / RDP on pretera-dc1
  - petrit.balani:    
  - lord.krasniqi:        ACE genericall-on-group Domain Admins and sdholder
  - mirjan.kastrati:   
- Ekzekutivi :        ACE Write Owner on group Burimet Njerezore
- Burimet Njerezore :         ACE generic all on user shkelqim.ekonomisti
- AccorsTheNarrowSea:       cross forest group

siguria.LOCAL
- TARGERYEN
  - missande :          ASREP roasting, generic all on Keljan
  - damian.ekspertet: DOMAIN ADMIN siguria
  - visjan.ekspertet:  ACE write property on jorah.Importet
  - jorah.Importet:      mssql execute as login / mssql trusted link / Read LAPS Password
- Llogaria
  - Keljan.Dobra:         mssql admin / GenericAll on visjan (shadow credentials) / GenericAll on ECS4
- DrejtoritFriends:       cross forest group
- Spys:                 cross forest group / Read LAPS password  / ACL generic all jorah.Importet

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
      - link :
        - to siguria-srv-1 : jon.Sina -> sa

- siguria
  - DC03  : siguria-dc.siguria.local (Windows Server 2016) (siguria DC)
    - Admins: damian.ekspertet (U)
    - RDP: ekspertet (G)

  - SRV03 : siguria-srv-1.siguria.local (Windows Server 2016) (MSSQL, SMB share)
    - Admins: Keljan.Dobra (U)
    - RDP: Llogaria (G)
    - MSSQL :
      - admin : Keljan.Dobra
      - impersonate :
        - execute as login : jorah.Importet -> sa
      - link:
        - to financa-srv-2: jorah.Importet -> sa

## Blueteam / ELK

- **elk** a kibana is configured on http://192.168.56.50:5601 to follow the lab events
- infos : log encyclopedia : https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/
- the elk is not installed by default due to resources reasons. 

- prerequistes: 
- you need `sshpass` for the elk installation
```bash
sudo apt install sshpass
```
- Chocolatey is needed to use elk. To install it run:
```bash
ansible-galaxy collection install chocolatey.chocolatey 
```

- To install and start the elk play the following commands :
```bash
./goad.sh -t install -l GOAD -p virtualbox -m local -r elk.yml -e elk
#or
./goad.sh -t install -l GOAD -p vmware -m local -r elk.yml -e elk
```

 * -e : to add the elk in vagrantfile for the vagrant up
 * -r : to run only the elk.yml ansible script

If you want to only launch the elk.yml file without providing (vm creation), because your elk vm is already up do :
```bash
./goad.sh -t install -l GOAD -p virtualbox -m local -a -r elk.yml -e elk
#or
./goad.sh -t install -l GOAD -p vmware -m local -a -r elk.yml -e elk
```

If you want to do that by hand:
  1. run: `GOAD_VAGRANT_OPTIONS=elk vagrant up`

  2. launch the elk provisionning with the command :
  ```
  cd ansible
  ansible-playbook -i ../ad/GOAD/data/inventory -i ../ad/GOAD/providers/<your_provider>/inventory elk.yml
  ```

### V2 breaking changes
- If you previously install the v1 do not try to update as a lot of things have changed. Just drop your old lab and build the new one (you will not regret it)
- Chocolatey is no more used and basic tools like git or notepad++ are no more installed by default (as chocolatey regularly crash the install due to hitting rate on multiples builds)
- ELK is no more installed by default to save resources but you still can install it separately (see the blueteam/elk part)
- Ekzekutivi vm as disappear and there is no more DC replication in the lab to save resources
- Wintefell is now a domain controller for the subdomain financa of the pretera.local domain

