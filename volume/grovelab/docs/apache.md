## Create config file
```
sudo vi /etc/apache2/sites-available/iandi.co.za.conf 
```

**Standard Domain**
```
<VirtualHost *:80>
 
  ServerName iandi.co.za 
  ServerAlias www.iandi.co.za
 
  ServerAdmin IandI@OneLove.Jah
  DocumentRoot /var/www/iandi.co.za
 
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
 
</VirtualHost> 
```

**Sub Domain**
```
<VirtualHost *:80>
  ServerName wiki.iandi.co.za
  DocumentRoot /var/www/wiki.iandi.co.za
</VirtualHost> 
```


## Set Apache Password Protected Directories With .htaccess File

**1. Make sure Apache is configured to use .htaccess file**
```     
<Directory /var/www/swag.iandi.co.za>
  Options Indexes Includes FollowSymLinks MultiViews
  AllowOverride AuthConfig
  Order allow,deny
  Allow from all
</Directory>
```     

**2. Create a password file with htpasswd**

Create directory outside apache document root, so that only Apache can access password file. The password-file should be placed somewhere not accessible from the web. This is so that people cannot download the password file:

```
mkdir -p /home/john/swag.iandi.co.za
```

**Add new user**
```
htpasswd -c /home/john/swag.iandi.co.za/apasswords username
```

**Allow apache user www-data to read our password file**

```     
chown www-data:www-data /home/john/swag.iandi.co.za/apasswords
chmod 0660 /home/john/swag.iandi.co.za/apasswords
```
     

**Create .htaccess file**

```     
cd /var/www/swag.iandi.co.za
vi .htaccess
```
     

**Add following text**

```     
AuthType Basic
AuthName "Restricted Access"
AuthUserFile /home/john/swag.iandi.co.za/apasswords
Require user username
```     


**Enable config file**
```bash
sudo a2ensite iandi.co.za.conf 
```     

## Disable OS Identity and Apache Version from Errors
```
     sudo vi /etc/apache2/apache2.conf  
```
Add or Edit
```
     ServerSignature Off 
     ServerTokens Prod  
```

**Disable Directory Listing**
```bash
     sudo vi /etc/apache2/sites-available/site.conf  
```
or
```bash
     sudo vi /etc/apache2/apache2.conf  
```
Add
```
<Directory /var/www/html>
    Options -Indexes
</Directory> 
```

## Secure Apache
### mod_security and mod_evasive modules 

Where `mod_security` works as a firewall for our web applications and allows us to monitor traffic on a real time basis. It also helps us to protect our websites or web server from brute force attacks. You can simply install `mod_security` on your server with the help of your default package installers.


Where `mod_evasive` works very efficiently, it takes one request to process and processes it very well. It prevents DDOS attacks from doing as much damage. This feature of `mod_evasive` enables it to handle the HTTP brute force and Dos or DDos attack. This module detects attacks with three methods.

1. If so many requests come to a same page in a few times per second. 
2. If any child process trying to make more than 50 concurrent requests. 
3. If any IP still trying to make new requests when its temporarily blacklisted.

**Install**
```bash
sudo apt-get install libapache2-mod-evasive libapache2-mod-security2 
```

**Enable Apache module**
```
sudo a2enmod mod_security && sudo a2enmod mode_evasion
```
**Restart Apache**
```
sudo service apache restart
```
[Apache security tips](http://www.tecmint.com/apache-security-tips/1)


## Enable GZip Compression in Apache

**Enable mods**
```
a2enmod deflate;a2enmod filter
```

**Add to Apache config**
```
<Directory>
  AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript image/svg+xml
</Directory>
```
## Enable caching

**Enable mods**
```
a2enmod expires; a2enmod headers
```

**Add to Apache config**
```
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresDefault "access plus 30 days"
  ExpiresByType text/html "access plus 1 day"
  ExpiresByType image/gif "access plus 30 days"
  ExpiresByType image/jpeg "access plus 30 days"
  ExpiresByType image/png "access plus 30 days"
  ExpiresByType text/css "access plus 30 days"
  ExpiresByType text/javascript "access plus 30 days"
  ExpiresByType application/x-javascript "access plus 30 days"
  ExpiresByType text/xml "access plus 30 days"
</IfModule>
```
