**Networking**

---

**Show connections/networks settings**
```
nmcli con show
```

**Delete connection**
```
nmcli con delete net-eth0
```

**Add connection**
```
nmcli con add con-name net-eth0 ifname eth0 type ethernet ip4 192.168.1.10/24 gw4 192.168.1.1
```

**Add/Modify DNS**
```
nmcli con mod net-eth0 ipv4.dns 8.8.8.8
```

**Modify the IP address and default gateway**
```
nmcli con modify net-eth0 ipv4.addresses "192.168.1.10/24 192.168.1.1"
```

**Later versions of Redhat & Centos 7 can use this to modify the gateway:**
```
nmcli con modify net-eth0 ipv4.gateway 192.168.1.1
```

**Apply settings**
Stop and Start the connection to apply new settings
```
nmcli con down net-eth0
nmcli con up net-eth0
```

**Show all network details of a connection**
```
nmcli con show net-eth0
```
