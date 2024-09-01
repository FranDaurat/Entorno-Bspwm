#!/bin/bash 

subfinder -d $1 -all -recursive > subdomains.txt 

cat subdomains.txt | sort -u | sponge subdomains.txt

httpx -l subdomains.txt -ports 80,8080,8888,8000,443 -threads 200 -sc -fc 404 -fr > subdomains_ALIVE.txt

rm -rf subdomains.txt
