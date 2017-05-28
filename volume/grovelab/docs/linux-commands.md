## Find 

**Find all matching files and replace with new file**
```bash
find ~/ -type f -iname "gameme.smx" | while read line
do
  cp -v gameme.smx $line
done
```

**Find and remove permissions**
```bash
find . -type f -iname "*.ini" -exec chmod -x {} \;
```

**Find files and grep**
```bash
find ~/ -type f -name "autoexec.cfg" -exec cat {} | grep 'log_address' \;
```

**Find and replace text in multiple files**
```bash
sed -i 's/"findtext"/"replacetext"/g' *
```

**Find text and replace the entire line**
```bash
sed -i 's/"^findtext.*"/"replacetext"/g' *
```

**Delete a specific subfolder within all directories**
```bash
echo ~/john/*/csgo/csgo/ | xargs -n 1 rm -r 
```

**Copy a specific sub directory from all directories.**
```bash
echo ~/john/*/ | xargs -n 1 cp -R csgo/
```
The -i option of cp command means that you will be asked whether to overwrite a file


**Find empty files and delete**
```
find /tmp -type f -empty -delete
```


## Listening on Ports, Traffic Network connections

**Find port of runnin application**
```bash
netstat -lnp | grep ts3
netstat -l -a -p -n  
```

**Find appliction listening on a port**
```bash
sudo lsof -i :80
```

**Monitor live Network connections and traffic**
```bash
sudo tcptrack -i eth0 -r 5 
```


## Hardware info

**All hardware info**
```bash
sudo lshw | less
```

**Motherbaord**
```bash
sudo lshw -c system
```

**Network**
```bash
sudo lshw -C network
```
**CPU**
```bash
sudo lscpu 
```

**PCI (GPU info here as well)**
```bash
sudo lspci 
```

**Memory**
```bash
free -h 
```

## Clone/Download a website

```bash
wget --limit-rate=200k --no-clobber --convert-links --random-wait -r -p -E -e robots=off -U mozilla http://www.kossboss.com 
```


## Download maps from csgo web server

```bash
wget -r --no-parent --reject "index.html*"  http://fastdl.streamline-servers.com/fastdl/ThomasL/5623//maps/ |grep surf 
```


## Mount Windows Partition that is in hibernation mode

```bash
sudo ntfsfix /dev/sda3 
sudo mount /dev/sda3 /mnt 
```


## Listing User Logins, reboot times and bad login attempts

**Get the running processes of logged-in users**
```bash
w
```

**Display Logged in users**
```bash
users 

who | cut -d' ' -f1 | sort | uniq
```

**Get all users login and logout history**
```bash
last 
```

**Get the users login history**
```bash
last [user] 
```

**Display bad login attempts**
```bash
last b 
```     

**Display last reboot times**
```bash
last reboot | less 
```


## Commonnly used


**Run a command every x seconds**
```bash
watch -n10 command args 
```

**Directory size disincluding sub directory info**
```bash
du -hs /path/to/directory 
```

**Find packages**
```bash
apt-cache search 
```

**Send mail**
```bash
echo "test message" | mailx -s 'test subject' john@domain.com  
```

**Number of files in dir**
```bash
ls | wc -l 
```

**Redirecting the standard error (stderr) and stdout to file**
```bash
command > file 2>&1  
```

**Get External/Public IP address:**
```bash
curl ifconfig.me
```

**Find installed packages(Ubuntu)**
```bash
dpkg -l | grep php 
```

**Update a single package using the CLI (Ubuntu)**
```bash
sudo apt-get --only-upgrade install <packagename> 
```    

## Compare files and directories content

```bash
diff file1 file2
diff /root/dir1/ /root/dir2/
```

**Compare file content with visual output</code>**
```bash
sdiff file1 file2
```


##Network manager

**View IP settings**
```bash
sudo service network-manager start 
```

Ubuntu 14.04
```bash
nmcli dev list iface eth0 
```

For newer versions, you can use this:
```bash
nmcli dev show eth0 
```


## UFW

**Find port and protocal**
```bash
ufw status numbered |(grep '80/tcp'|awk -F"[][]" '{print $2}')
```

**Delete port**
```bash
ufw delete $(ufw status numbered |(grep '80/tcp'|awk -F"[][]" '{print $2}'))
```

**Delete firewall rules on cli and auto select yes**
```bash
yes | for i in {50..3}; do sudo ufw delete $i; done
```


## ImageMagick - Command Line Image Manipulation

**Installation**
```bash
sudo apt-get install imagemagick 
sudo yum -y install ImageMagick 
```

**Converting Between Formats**
```bash
convert howtogeek.png howtogeek.jpg 
```

**Resize Images**
```bash
convert example.png -resize 200×100 example.png
```

**Resize Images & Preserve aspect ratio**
```bash
convert example.png -resize 200×100! example.png 
```

**Rotate Image**
```bash
convert howtogeek.jpg -rotate 90 howtogeek-rotated.jpg 
```

**Converting Between Formats & Changing quality**
```bash
convert howtogeek.png -quality 95 howtogeek.jpg 
```
The Last example shows you that you can combined operations.


## TMUX & screen

**Start new with session name**
```bash
tmux new -s myname
```

**Attach**
```bash
tmux a tmuxname
```

**Attach to named**
```bash
tmux a -t myname
```

**List sessions**
```bash
tmux ls
```

**Kill session**
```bash
tmux kill-session -t myname
```

**Inject a command to a detached screen**
```bash
screen -p 0 -X stuff $'bot_kill\n'
```


## Curl

**Get Response code**
```bash
curl -sI https://$SITE | head -1
```


## Dig

**Reverse DNS lookup** 
```bash
dig +noall +answer -x 199.232.99.199
```    
`-x`Reverse DNS lookup   
`+noall` and `+answer` makes output pretty

