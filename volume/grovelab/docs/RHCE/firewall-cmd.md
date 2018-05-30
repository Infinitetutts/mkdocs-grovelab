## Firewalld / Firewall-cmd

---


* Temporary rules get activated immidiatly

* To Activate permanent rules one needs to reload firewalld.

* If you dont specify a zone, your default zone will be used.

**Get Firewalld state**
```bash
firewall-cmd --state
```

**Get Active Zones**

Zones are a group firewall rules
```bash
firewall-cmd --get-active-zones
```

**List all active zones and rules**
```bash
firewall-cmd --list-all
```

**View all firewall rules of a zone**
```bash
firewall-cmd --zone=public --list-all
cat /etc/firewalld/zones/public.xml
```

**List whitelisted services/ports**
```bash
firewall-cmd --list-services
firewall-cmd --list-ports
```

**Get services**

Lists all services a person can whitelist
```bash
firewall-cmd --get-services
ls /usr/lib/firewalld/services/
```

**Whitelist service,port and multiple ports**
```bash
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --add-port=1000-1010/udp
```

**Reload**
```bash
firewall-cmd --reload
```

**Remove Service or Port**
```bash
firewall-cmd --permanent --remove-service=http
firewall-cmd --permanent --remove-port=443/tcp
```
