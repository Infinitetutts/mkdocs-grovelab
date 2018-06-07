# NFS / Kerborized NFS
---

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

