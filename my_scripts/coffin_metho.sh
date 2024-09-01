#!/bin/bash

subfinder -d $1 -all -recursive > sub.txt 

httpx -l sub.txt -ports 80,8080,8888,8000,443 -threads 200  > sub_Alive.txt

cat sub_Alive.txt | sort -u | sponge sub_Alive.txt

# naabu -list subdomains_Alive.txt -c 50 -nmap-cli 'nmap -sV -sC' -o naabu-full.txt

# dirsearch -l sub_Alive.txt -i 200,204,403,443 -x 500,502,429,501,503 -R 5 --random-agent -t 50 -F -w /home/elgordoponcio/Desktop/all_coffin_things/oneListForall/onelistforallshort.txt -o directory.txt

cat sub_Alive.txt | gau --providers wayback,commoncrawl,otx,urlscan --verbose > newparms.txt
cat newparms.txt | uro > filterparm.txt

rm -rf sub.txt sub_Alive.txt
mkdir secrets 


cat filterparm.txt | sort -u | httpx -fc 404 -threads 200 | sponge filterparm.txt

cat filterparm.txt | grep ".js$" > jsfiles.txt

cat jsfiles.txt | while read url; do python3 /home/elgordoponcio/go/bin/SecretFinder.py -i $url -o cli >> ./secrets/secret.txt; done


cat secret.txt | grep -i aws > ./secrets/secretAWS.txt
cat secret.txt | grep -i google > ./secrets/secretGOOGLE.txt
cat secret.txt | grep -i twilio > ./secrets/secretTWILIO.txt
cat secret.txt | grep -i heroku > ./secrets/secretHEROKU.txt

nuclei -list filterparm.txt -t /home/elgordoponcio/.local/nuclei-templates


