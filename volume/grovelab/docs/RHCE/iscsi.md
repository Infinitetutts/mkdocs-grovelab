### Overview

** iSCSI Terminology **

--- 

- **SAN:** Storage Area Networks
- **IQN:** The iSCSI Qualified Name, a unique name used for identifying targets as well as initiators
- **Initiator:** The iSCSI client that is identified by an IQN
- **Target:** The service on an iSCSI server that gives access to the backend storage devices
- **ACL:** an Access Control List that is based on node IQN's.
- **portal:** the IP address and port that a target or initiator uses to establish connection; also referred to as nodes.
- **discovery:** the process where an initiator finds the targets that are configured on a portal
- **LUN:** the block devices shared through the target
- **login:** authentication that gives an initiator access to LUNs
- **TPG:** Target Portal Group, the collection of IP addresses and TCP ports to which a specific iSCSI target will listen.
---

**Requirement: 2 partitions to use as block devices**

1. Attach a 1GB HDD to server1 in Virtualbox
2. Create 2 Partitions. Please see [create a partition (lvm)](lvm-partition.md) 



**Server setup**

- server1: 192.168.88.91
- server2: 192.168.88.92
- server3: 192.168.88.93
- **Target:** server1
- **Initiators:** server2, server3

**Objective**

- Share blocks or partitions and a file on the Target which will be accesible by Initiators

**Install & enable targetcli**
```bash
yum install -y targetcli
systemctl enable target
```

**Whitelist the target application port**
```bash
firewall-cmd --add-port=3260/tcp --permanent
firewall-cmd --reload
```

### Setup an iSCI Target (Server)

**Open targetcli**
```bash
targetcli
```

**View confiuration**
```
ls

o- / …………………………………………………………………………………………………………. […]
o- backstores ……………………………………………………………………………………………….. […]
| o- block …………………………………………………………………………………….. [Storage Objects: 0]
| o- fileio ……………………………………………………………………………………. [Storage Objects: 0]
| o- pscsi …………………………………………………………………………………….. [Storage Objects: 0]
| o- ramdisk …………………………………………………………………………………… [Storage Objects: 0]
o- iscsi ……………………………………………………………………………………………… [Targets: 0]
o- loopback …………………………………………………………………………………………… [Targets: 0]
```

**Create blocks and file**

These devices are automatically mounted to an initiator 
```
cd backstores/block/
create dev=/dev/vgsan/lvsan1 name=block1
create dev=/dev/vgsan/lvsan2 name=block2
```
*The file is create automatically by iSCSI*
```
cd backstores/fileio/
create file_or_dev=file1.img name=file1 size=100M
```

**Create an TPG IQN**
```
cd /iscsi/
create wwn=iqn.2018-05.com.example:target1
```

**Create acl**

*Create ACL before LUNS, as ACL settings are automatically copied to newly created LUNS*
```
cd iscsi/iqn.2018-05.com.example:target1/tpg1/
create wwn=iqn.2018-05.com.example:client
```

**Create luns**
```
cd /iscsi/iqn.2018-05.com.example:target1/tpg1/luns
create storage_object=/backstores/block/block1
create storage_object=/backstores/block/block2
create storage_object=/backstores/fileio/file1
```

**View confiuration**
```
/> ls
o- / ............................................................................... [...]
  o- backstores .................................................................... [...]
  | o- block ........................................................ [Storage Objects: 2]
  | | o- block1 ...................... [/dev/vgsan/lvsan1 (500.0MiB) write-thru activated]
  | | | o- alua ......................................................... [ALUA Groups: 1]
  | | |   o- default_tg_pt_gp ............................. [ALUA state: Active/optimized]
  | | o- block2 ...................... [/dev/vgsan/lvsan2 (500.0MiB) write-thru activated]
  | |   o- alua ......................................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ............................. [ALUA state: Active/optimized]
  | o- fileio ....................................................... [Storage Objects: 1]
  | | o- file1 ............................... [file1.img (100.0MiB) write-back activated]
  | |   o- alua ......................................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ............................. [ALUA state: Active/optimized]
  | o- pscsi ........................................................ [Storage Objects: 0]
  | o- ramdisk ...................................................... [Storage Objects: 0]
  o- iscsi .................................................................. [Targets: 1]
  | o- iqn.2018-05.com.example:target1 ......................................... [TPGs: 1]
  |   o- tpg1 ..................................................... [no-gen-acls, no-auth]
  |     o- acls ................................................................ [ACLs: 2]
  |     | o- iqn.2018-05.com.example:server2 ............................ [Mapped LUNs: 3]
  |     | | o- mapped_lun0 ...................................... [lun0 block/block1 (rw)]
  |     | | o- mapped_lun1 ...................................... [lun1 block/block2 (rw)]
  |     | | o- mapped_lun2 ...................................... [lun2 fileio/file1 (rw)]
  |     | o- iqn.2018-05.com.example:server3 ............................ [Mapped LUNs: 3]
  |     |   o- mapped_lun0 ...................................... [lun0 block/block1 (rw)]
  |     |   o- mapped_lun1 ...................................... [lun1 block/block2 (rw)]
  |     |   o- mapped_lun2 ...................................... [lun2 fileio/file1 (rw)]
  |     o- luns ................................................................ [LUNs: 3]
  |     | o- lun0 .................. [block/block1 (/dev/vgsan/lvsan1) (default_tg_pt_gp)]
  |     | o- lun1 .................. [block/block2 (/dev/vgsan/lvsan2) (default_tg_pt_gp)]
  |     | o- lun2 .......................... [fileio/file1 (file1.img) (default_tg_pt_gp)]
  |     o- portals .......................................................... [Portals: 1]
  |       o- 0.0.0.0:3260 ........................................................... [OK]
  o- loopback ............................................................... [Targets: 0]
```

**Save config**
```
cd /
saveconfig
```

**Create/delete portal(Not required)**
```
cd iscsi/iqn.2018-05.com.example:target1/tpg1/portals/
delete ip_address=0.0.0.0 ip_port=3260
create ip_address=192.168.88.91 ip_port=3260
```

### Setup an iSCSI Initiator (Client)

**Install iSCSI client cli (iscsiadm)**
```bash
yum -y install iscsi-initiator-utils
```

**Add the authentication client "iqn.2018-05.com.example:client" to initiatorname.isci**
```bash
vim /etc/iscsi/initiatorname.iscsi
```
```
InitiatorName=iqn.2018-05.com.example:client
```

**Get examples of commands**
```bash
man iscsiadm
```

**Discover a Target**
```bash
iscsiadm --mode discoverydb --type sendtargets --portal 192.168.88.91 --discover
```
**Login to Target**
```bash
iscsiadm --mode node --targetname iqn.2018-05.com.example:target1 --portal 192.168.88.91 --login
```

**Displays iSCSI blocks,files,etc on connected target**
```bash
yum -y install lsscsi
```
```bash
[root@server2 ~]# lsscsi
[0:0:0:0]    disk    ATA      VBOX HARDDISK    1.0   /dev/sda
[2:0:0:0]    cd/dvd  VBOX     CD-ROM           1.0   /dev/sr0
[13:0:0:0]   disk    LIO-ORG  block1           4.0   /dev/sdb
[13:0:0:1]   disk    LIO-ORG  block2           4.0   /dev/sdc
[13:0:0:2]   disk    LIO-ORG  file1            4.0   /dev/sdd
```

**iSCSI remembers login on reboot, logout to remove**
```bash
iscsiadm -m node -1 iqn.2003-01.local.rhce.ipa:target -p 10.8.8.70:3260 --logout
```

**Delete Configuration**
```bash
iscsiadm -m node -T iqn.2003-01.local.rhce.ipa:target -p 10.8.8.70:3260 -o delete
```

**Display info**
```bash
iscsiadm -m session -P <{1-3}>
iscsiadm -m node -P 1
iscsiadm -m discovery -P 0
```
