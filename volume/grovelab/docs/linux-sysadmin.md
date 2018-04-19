## DDOS Mitigation Process
### Working with Logs, IpTables, Apache, Wordpress logins

**Look at top IP addresses in your access log use:**
```bash
tail -n 10000 access.log|cut -f 1 -d ' '|sort|uniq -c|sort -nr|more 
```

**If nothing looks suspicious in IP the list, use this query to check top hit URLs on your box:**
```bash
cut -f 2 -d '"' access.log|cut -f 2 -d ' '|sort|uniq -c|sort -nr|more 
```

**Check for common user agents :** 
```bash
cut -f 4 -d '"' access.log|sort|uniq -c|sort -nr|more 
```

**Get IP's of established connections**
```bash
netstat -an|grep ESTABLISHED|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|awk '{ printf("%s\t%s\t",$2,$1); for (i = 0; i < $1; i++) {printf("*")}; print ""}' 
```

**View Apache requests per day**
```bash
cd /var/log/apache2 
awk '{print $4}' access.log | cut -d: -f1 | uniq -c 
```

**View Apache requests per hour**
```bash
cd /var/log/apache2 
grep "29/Feb" access.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c 
```

**View Apache requests per minute**
```bash
cd /var/log/apache2 
grep "29/Feb/2016:06" access.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":"$3}' | sort -nk1 -nk2 | uniq -c | awk '{ if ($1 > 10) print $0}' 
```

**View WordPress login and hacking attempts**
```bash
egrep "POST .*wp-login.php" access.log | awk '{print $1,$4,$5,$6,$7,substr($0, index($0,$12))}' | awk '{print $1}' | sort -n | uniq -c | sort -n | sed 's/[ ]*//' 
egrep "POST .*xmlrpc.php" access.log | awk '{print $1,$4,$5,$6,$7,substr($0, index($0,$12))}' | awk '{print $1}' | sort -n | uniq -c | sort -n | sed 's/[ ]*//' 
```

**Number of failed ssh login attempts**
```bash
zcat /var/log/auth.log* | grep 'Failed password' | grep sshd | awk '{print $1,$2}' | sort -k 1,1M -k 2n | uniq -c 
```

**DDos mitigation by limiting connections**
```bash
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT 
```
`-m limit` This uses the limit iptables extension.    
`--limit 25/minute` This limits only maximum of 25 connection per minute. Change this value based on your specific requirement.   
`--limit-burst 100` This value indicates that the limit/minute will be enforced only after the total number of connection have reached the limit-burst level.   


**Block an IP on iptables:**
```bash
iptables -A INPUT -s <IPADRESS> -j DROP/REJECT  
```

Example
```bash
iptables -A INPUT -s 192.168.1.1 -j DROP/REJECT 
```

**Save and Restart**
```bash
service iptables restart 
service iptables save 
sudo service apache2 restart  
```


## Remove sudo password prompt

**Open sudoers config file**
```bash
sudo visudo 
```
**Edit or Add the group the user is apart of. All users in this group passwords will be removed**
```bash
%sudo ALL=(ALL) NOPASSWD: ALL 
```

## SSH Key Based Authentication and Create Config

**Generate ssh key**  
<s>`ssh-keygen -C "your_email@example.com"`</s>

**Generate secure ssh key**
```bash 
ssh-keygen -o -a 100 -t ed25519 -C "your_email@example.com"
```
`-C` Comment - Use any identifier: name/username/email/etc


**Copy SSH key from pc to server**
```bash
ssh-copy-id username@remote_host 
```

**Create config for a quick way to connect via ssh**
```bash
vi /home/john/.ssh/config 

Host iandi
HostName iandi.co.za
User john
IdentityFile /home/john/.ssh/iandi 
```

**Your config file you just created will allow you to connect via SSH much faster**
```bash
ssh iandi 
```


## Automatically Start script on reboot

**Create script**
```bash
sudo vi /etc/init.d/script.sh 
sudo chmod 755 /etc/init.d/script.sh
```

**Set script to start automatically on boot with**
Centos
```bash
sudo chkconfig --add script.sh 
```

**Enable script on run levels**
```bash
sudo chkconfig --level 2345 script.sh on 
```

**Check the script is indeed enabled - you should see "on" for the levels you selected.**
```bash
sudo chkconfig --list | grep script.sh 
```

**Remove script from startup chkconfig --del script.sh**
Ubuntu
```bash
sudo update-rc.d script.sh defaults 
```
Remove script from startup
```bash
update-rc.d -f script.sh remove 
```
Check the script is indeed enabled
```bash
service --status-all 
```
`[ + ]` Services with this sign are currently running.  
`[ – ]` Services with this sign are not currently running.   
`[ ? ]` Services that do not have a status switch. 


## Delete clean cache to free up memory

Writing to this will cause the kernel to drop clean caches, as well as reclaimable slab objects like dentries and inodes. Once dropped, their memory becomes free.

To free pagecache:
```bash
sync;echo 1 > /proc/sys/vm/drop_caches
```
To free reclaimable slab objects (includes dentries and inodes):
```bash
sync;echo 2 > /proc/sys/vm/drop_caches
```
To free slab objects and pagecache:
```bash
sync;echo 3 > /proc/sys/vm/drop_caches
```
This is a non-destructive operation and will not free any dirty objects. Use of this file can cause performance problems. Since it discards cached objects, it may cost a significant amount of I/O and CPU to recreate the dropped objects, especially if they were under heavy use.

“sync” only makes dirty cache to clean cache. cache is still preserved. drop_caches doesn’t touch dirty caches and only drops clean caches. So to make all memory free, it is necessary to do sync first before drop_caches in case flushing daemons hasn’t written the changes to disk.


## Easy SMTP Server Setup

```bash
sudo apt-get install sendmail 
sudo sendmailconfig 
```

## UFW Disable IPv6 rules

```bash
sudo vim /etc/default/ufw 
IPV6=no 
```
