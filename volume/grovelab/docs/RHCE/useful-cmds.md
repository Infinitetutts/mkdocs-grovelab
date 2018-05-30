**Useful Commands**

---

**Check if service is enabled**
```bash
systemctl is-enabled sshd
```

**Install auto completion**
```bash
yum -y install bash-completion
```

**Python breaks if no default language output is set**
```bash
echo "export LC_ALL=C" >> ~/.bashrc
source ~/.bashrc
```
