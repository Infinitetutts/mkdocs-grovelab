## awk, sed, cut ,grep, tail

**Removing quotes**

    awk '{ print "\""$0"\""}' inputfile

**Using pure bash**

    while read FOO; do
       echo -e "\"$FOO\""
    done < inputfile 

where inputfile would be a file containing the lines without quotes.



**If your file has empty lines, awk is definitely the way to go:**

    awk 'NF { print "\""$0"\""}' inputfile 

NF tells awk to only execute the print command when the Number of Fields is more than zero (line is not empty).

     awk '{ print "\""$0"\""}' mapcycle_surf.txt > mapcycle_surf1.txt


**AWK's printf, NR and $0 make it easy to have precise and flexible control over the formatting**

     awk '{printf("%010d %s\n", NR, $0)}' maplist.txt

0000000001 surf_map1 0000000002 surf_map2 0000000003 surf_map3


    awk '{printf("%d %s \n", NR, $0)}' mapcycle_surf1.txt 

1 "surf_004_final1" 2 "surf_1day" 3 "surf_2012_beta12"


    awk '{printf("%s %d \n" ,$0 , NR)}' mapcycle_surf1.txt 

"surf_004_final1" 1 "surf_1day" 2 "surf_2012_beta12" 3


    awk '{printf("%s \"%d\" \n" ,$0 , NR)}' mapcycle_surf1.txt 

"surf_004_final1" "1" "surf_1day" "2" "surf_2012_beta12" "3"


    awk '{printf("%s \"%d\" \n" ,$0 , NR-1)}' mapcycle_surf1.txt > mapcycle_surf.txt 

cat mapcycle_surf.txt "surf_004_final1" "0" "surf_1day" "1" "surf_2012_beta12" "2" "surf_3" "3"


String to replace: "surf_prime_time_r3vamp /"

    sed -i -E "s,surf_[A-Za-z0-9]+_?-?[A-Za-z0-9]+_?[A-Za-z0-9]+\s/, 123," workmaps.txt 

-i input file -E Regex


**Remove empty lines**

    sed -i -E "s,^\s*$,," workmaps.txt 


**Remove the first character sed**

    cat input_file | sed 's/^..//' > output_file



Instead of selecting x number of characters, if you like to extract a whole field, you can combine option -f and -d. The option -f specifies which field you want to extract, and the option -d specifies what is the field delimiter that is used in the input file.

The following example displays only first field of each lines from /etc/passwd file using the field delimiter : (colon). In this case, the 1st field is the username. The file

    cut -d':' -f1 /etc/passwd


**Search and replace string**

    find . -type f -name "gamemode_comp*" -exec sed -i 's/YB53XUH3/"J123f34J123454!^dfg"/g' {} + 


    awk '{print $3}' maps.txt 

before: [ ] surf_zion.nav.bz2 2015-06-21 18:27 132

after: surf_whoknows.nav.bz2


**Displays unique values from compared files**

    grep -v -f <compare-file-1> <compare-file-2> 

**Search and replace text in multiple files and escape special characters**

    sed -i 's/test.data\*\.keyboard/test\.\*\.keyboard/g' *

before: test.data*.keyboard

after: test.*.keyboard


**Escape Characters**

    sed -i 's/\(foo\)/bin/g' file.json


**Replace string but keep indention or spaces**

    sed -i  '/"interval":/i \ \ \ \ \ \ "occurrences": 2,' file.json


**Append line after match**

    sed  '/\[option\]/a Hello World' input


**Insert line before match**

    sed  '/\[option\]/i Hello World' input


**Delete first 4 lines and last 4 lines from a text file**

     tail -n +5 test.json | head -n -4 > test.json.new && mv test.json.new test.json

     tail -n +5 srv_ssh.json | head -n -4 > test.json.new && mv test.json.new srv_ssh.json


**Remove duplicate lines**

     sort file.log | uniq > newfile.log


**Sort strings by length**

     awk '{ print length($0),$0 | "sort -n"}'  usragnt.txt

**Display files that do not have string:**

     grep -L "foo" *

**Display files that do have string**

     grep -n "foo" *

