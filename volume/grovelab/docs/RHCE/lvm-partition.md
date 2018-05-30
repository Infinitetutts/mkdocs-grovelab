** Create a partiton with lvm **

--- 

*If you are using Virtual box, you can simply attach an additional HDD to your virtual machine.*

**Partitions CMDS**
```bash
- pvs                    # Display information about physical volumes
- lvs                    # Display information about logical volumes
- vgs                    # Display information about volume groups
```

**View available disks**
```bash
lsblk
```
```bash
[root@server1 ~]# lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda             8:0    0    8G  0 disk
|-sda1          8:1    0  500M  0 part /boot
`-sda2          8:2    0  7.5G  0 part
  |-rhel-root 253:0    0  6.7G  0 lvm  /
    `-rhel-swap 253:1    0  820M  0 lvm  [SWAP]
    sdb             8:16   0    1G  0 disk
    sr0            11:0    1 1024M  0 rom
```

**Create a volume group**
```bash
vgcreate vgsan /dev/sdb
```

**Create a logical volume**
```bash
lvcreate -L 500M -n lvsan1 vgsan
lvcreate -L 500M -n lvsan2 vgsan
```
