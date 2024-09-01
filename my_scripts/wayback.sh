#!/bin/bash

waybackurls $1 | httpx -sc -fc 404 > wayback_filtered
cat wayback_filtered | sed 's/=.*/=/' | grep '=$' > wayback_cleanParams


