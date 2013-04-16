#!/bin/bash

cd /home/gitback/backups

USERS=`python -c "import requests
for u in requests.get('https://api.github.com/orgs/FOSSRIT/public_members').json():
    print u['login']"`

for user in $USERS
do
    /home/gitback/github_backup.sh $user
done

/home/gitback/github_backup.sh FOSSRIT org
