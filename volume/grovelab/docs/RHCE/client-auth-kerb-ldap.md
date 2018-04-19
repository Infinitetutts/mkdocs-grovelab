**Setup IPA Server**

- [Setup IPA server video](https://www.youtube.com/watch?v=5NyWr7kMfRI&t)
- [Setup IPA server blog](https://read.phabtech.com/index.php/2017/07/24/ipaserver-configuration/)

---

**Client Authentication With Kerberos to IPA Server**

--- 

**Install packages**
```
yum install nss-pam-ldapd pam_krb5
```

**Configure authentication**
```
authconfig-tui
```
```
[*] Use LDAP
[*] Use Kerberos
  Next
[*] Use TLS
Server: ldap://ipa.example.com
Base DN: dc=example,dc=com
  Next
Realm: EXAMPLE.COM
[*] Use DNS to resolve hosts to realms
[*] Use DNS to locate KDCs for realms
```

**Copy the certificate**
```
scp root@ipa.example.com:/root/cacert.p12 /etc/openldap/cacerts/
```

**Uncomment the line "#tls_reqcert never" from nslcd.conf**
```
vim /etc/nslcd.conf
```

**Apply settings**
```
systemctl restart nslcd
```

**Test if authentication is working**
```
getent passwd ldapuser1
su - ldapuser1
```
