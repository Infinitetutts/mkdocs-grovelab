**Useful Commands**

---

**Check if service is enabled**
```
systemctl is-enabled sshd
```

**Install auto completion**
```
yum -y install bash-completion
```

**Python breaks if no default language output is set**
```
echo "export LC_ALL=C" >> ~/.bashrc
source ~/.bashrc
```
