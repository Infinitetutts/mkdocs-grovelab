### Install application from tar ball

*We will use Sublime3 for this example*

**Download the Latest version of Sublime3**

**Extract to /opt. This will be the installed directory**
```bash
sudo tar -vxjf sublime_text_3_build_3065_x64.tar.bz2 -C /opt 
```

**Create Soft link. This directory holds all command executables.**
```bash
sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime3 
```

**Open Sublime 3 from terminal**
```bash
sublime3
```

## Create Gnome desktop launcher
```bash
sudo vi sublime3 /usr/share/applications/sublime3.desktop 
```
```     
[Desktop Entry]
Name=Sublime3
Exec=sublime3
Terminal=false
Icon=/opt/sublime_text_3/Icon/48x48/sublime-text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow
 
[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
```     
