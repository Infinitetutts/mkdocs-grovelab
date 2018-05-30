**nmcli**

---

**Show connections/networks settings**
```bash
nmcli con show
```

**Delete connection**
```bash
nmcli con delete eth0
```

**Add connection**
```bash
nmcli con add con-name eth0 ifname eth0 type ethernet ip4 192.168.1.10/24 gw4 192.168.1.1
```

**Add/Modify/Remove DNS**
```bash
nmcli con mod eth0 ipv4.dns 8.8.8.8
```
```bash
nmcli connection edit eth0
nmcli> remove ipv4.dns  
nmcli> set ipv4.ignore-auto-dns yes
nmcli> set ipv4.dns 8.8.8.8     
nmcli> save
nmcli> quit
```

**Modify the IP address and default gateway**
```bash
nmcli con modify eth0 ipv4.addresses "192.168.1.10/24 192.168.1.1"
```

**Later versions of Redhat & Centos 7 can use this to modify the gateway:**
```bash
nmcli con modify eth0 ipv4.gateway 192.168.1.1
```

**Apply settings**
Stop and Start the connection to apply new settings
```bash
nmcli con down eth0
nmcli con up eth0
```

**Show all network details of a connection**
```bash
nmcli con show eth0
```
