## Checking logs, IpTables, Apache, Wordpress logins

**Look at top IP addresses in your access log use:**
```bash
tail -n 10000 access.log|cut -f 1 -d ' '|sort|uniq -c|sort -nr|more 
```

**If nothing looks suspicious in IP list, use this query to check top hit URLs on your box:**
```bash
cut -f 2 -d '"' access.log|cut -f 2 -d ' '|sort|uniq -c|sort -nr|more 
```

**Check for common user agents :** 
```bash
cut -f 4 -d '"' access.log|sort|uniq -c|sort -nr|more 
```

** Live IPs from established connections **
```bash
     netstat -an|grep ESTABLISHED|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|awk '{ printf("%s\t%s\t",$2,$1); for (i = 0; i < $1; i++) {printf("*")}; print ""}' 
```

** Apache requests per day **
```bash
     cd /var/log/apache2 
     awk '{print $4}' access.log | cut -d: -f1 | uniq -c 
```

View Apache requests per hour

     cd /var/log/apache2 

     grep "29/Feb" access.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c 

View Apache requests per minute

     cd /var/log/apache2 

     grep "29/Feb/2016:06" access.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":"$3}' | sort -nk1 -nk2 | uniq -c | awk '{ if ($1 > 10) print $0}' 

View WordPress login and hacking attempts

     egrep "POST .*wp-login.php" access.log | awk '{print $1,$4,$5,$6,$7,substr($0, index($0,$12))}' | awk '{print $1}' | sort -n | uniq -c | sort -n | sed 's/[ ]*//' 

     egrep "POST .*xmlrpc.php" access.log | awk '{print $1,$4,$5,$6,$7,substr($0, index($0,$12))}' | awk '{print $1}' | sort -n | uniq -c | sort -n | sed 's/[ ]*//' 

Number of failed ssh login attempts

     zcat /var/log/auth.log* | grep 'Failed password' | grep sshd | awk '{print $1,$2}' | sort -k 1,1M -k 2n | uniq -c 

DDos mitigation by limiting connections

     iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT 

   -m limit: This uses the limit iptables extension
   –limit 25/minute: This limits only maximum of 25 connection per minute. Change this value based on your specific requirement
   –limit-burst 100: This value indicates that the limit/minute will be enforced only after the total number of connection have reached the limit-burst level.


To block an IP on iptables:

     iptables -A INPUT -s <IPADRESS> -j DROP/REJECT  

Example

     iptables -A INPUT -s 192.168.1.1 -j DROP/REJECT 

Save and Restart

     service iptables restart 

     service iptables save 

     sudo service apache2 restart  



## Backup all changed config files
```bash
debsums -ce | tar --files-from=- -cf configs.tar 
```
