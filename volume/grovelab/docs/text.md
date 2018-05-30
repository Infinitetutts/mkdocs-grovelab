## AWK

**Removing quotes**
```bash
awk '{ print "\""$0"\""}' inputfile
```
If your file has empty lines, awk is definitely the way to go
```bash
awk 'NF { print "\""$0"\""}' inputfile.txt > newfile.txt
```
`NF` tells awk to only execute the print command when the Number of Fields is more than zero (line is not empty).

**Print 3rd field**
```bash
awk '{print $3}' maps.txt 
```

**Sort strings by length**
```bash
awk '{ print length($0),$0 | "sort -n"}'  usragnt.txt
```

**Examples**  

AWK's `printf`, `NR` and `$0` make it easy to have precise and flexible control over the formatting

```bash
awk '{printf("%010d %s\n", NR, $0)}' maplist.txt
```
Output:    
*0000000001 surf_map1*   
*0000000002 surf_map2*  
*0000000003 surf_map3*  


```bash
awk '{printf("%d %s \n", NR, $0)}' mapcycle_surf1.txt 
```
Output:  
*1 "surf_004_final1"*   
*2 "surf_1day"*   
*3 "surf_2012_beta12"* 


```bash
awk '{printf("%s %d \n" ,$0 , NR)}' mapcycle_surf1.txt 
```
Output:   
*"surf_004_final1" 1*   
*"surf_1day" 2*   
*"surf_2012_beta12" 3* 


```bash
awk '{printf("%s \"%d\" \n" ,$0 , NR)}' mapcycle_surf1.txt 
```
Output:    
*"surf_004_final1" "1"*   
*"surf_1day" "2"*  
*"surf_2012_beta12" "3"*


```bash
awk '{printf("%s \"%d\" \n" ,$0 , NR-1)}' mapcycle_surf1.txt > mapcycle_surf.txt 
```
Output:    
*"surf_004_final1" "0"*   
*"surf_1day" "1"*   
*"surf_2012_beta12" "2"*  
*"surf_3" "3"*  


## SED & REGEX

**Find and replace using REGEX**    
String to replace `surf_prime_time_r3vamp /`
```bash
sed -i -E "s,surf_[A-Za-z0-9]+_?-?[A-Za-z0-9]+_?[A-Za-z0-9]+\s/, 123," workmaps.txt 
```
`-i` input file   
`-E` Regex

**Remove empty lines**
```bash
sed -i -E "s,^\s*$,," workmaps.txt 
```

**Remove the first character sed**
```bash
cat input_file | sed 's/^..//' > output_file
```


**Search and replace text in multiple files and escape special characters**
```bash
sed -i 's/test.data\*\.keyboard/test\.\*\.keyboard/g' *
```
Before: `test.data*.keyboard`
After: `test.*.keyboard`

**Escape Characters**
```bash
sed -i 's/\(foo\)/bin/g' file.json
```

**Replace string but keep indention or spaces**
```bash
sed -i  '/"interval":/i \ \ \ \ \ \ "occurrences": 2,' file.json
```

**Append line after match**
```bash
sed  '/\[option\]/a Hello World' input
```

**Insert line before match**
```bash
sed  '/\[option\]/i Hello World' input
```

**Search and replace string**
```bash
find . -type f -name "gamemode_comp*" -exec sed -i 's/YB53XUH3/"J123f34J123454!^dfg"/g' {} + 
```
Before: `[ ] surf_zion.nav.bz2 2015-06-21 18:27 132`
After: `surf_whoknows.nav.bz2`

## CUT
**Displayfirst field after delimenator**
```bash
cut -d':' -f1 /etc/passwd
```
Prints the usernames from `/etc/passwd`


## TAIL
**Delete first 4 lines and last 4 lines from a text file**
```bash
tail -n +5 srv_ssh.json | head -n -4 > test.json.new && mv test.json.new srv_ssh.json
```


## Sort
**Remove duplicate lines**
```bash
sort file.log | uniq > newfile.log
```


## GREP
**Display files that do not have string:**
```bash
grep -L "foo" *
```

**Display files that do have string**
```bash
grep -n "foo" *
```

**Displays unique values from compared files**
```bash
grep -v -f <compare-file-1> <compare-file-2> 
```
