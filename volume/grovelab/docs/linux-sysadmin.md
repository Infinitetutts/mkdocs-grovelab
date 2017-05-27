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

## Backup all changed config files
```bash
debsums -ce | tar --files-from=- -cf configs.tar 
```
