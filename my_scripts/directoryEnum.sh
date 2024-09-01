#!/bin/bash 

dirsearch -u $1 -i 200,204,403,443 -x 500,502,429,501,503 -R 5 --random-agent -t 120 -F -w /home/elgordoponcio/Desktop/all_coffin_things/oneListForall/onelistforallshort.txt -o directory.txt


cat directory.txt | sort -u | sponge directory.txt
cat directory.txt | grep -vE "403|200" > directoryETC.txt
cat directory.txt | grep "200" > directory200.txt
cat directory.txt | grep "403" > directory403.txt

mkdir directory_enum
mv directory* directory_enum

