## Create a bootable USB

**1. Convert the .iso file to .img**
```
hdiutil convert -format UDRW -o ~/path/to/target.img ~/path/to/ubuntu.iso
```
**2. Determine the device node assigned to your flash media (e.g. /dev/disk2).**
```
diskutil list
```
**3. Unmount**
```
diskutil unmountDisk /dev/diskN
```
**4. Write Image to USB**
```
sudo dd if=/path/to/downloaded.img of=/dev/rdiskN bs=1m
```
Using `/dev/rdisk` instead of `/dev/disk` may be faster.     
If you see the error `dd`: `Invalid number '1m'`, you are using GNU `dd`. Use the same command but replace `bs=1m` with `bs=1M`


**5. Safely Remove USB when completed**
```
diskutil eject /dev/diskN
```
