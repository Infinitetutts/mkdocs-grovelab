## Find 
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

**Find port of runnin application**
```bash
netstat -lnp | grep ts3
netstat -l -a -p -n  
```

**Find appliction listening on a port**
```bash
sudo lsof -i :80
```
