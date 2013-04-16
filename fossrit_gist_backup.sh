#!/bin/bash

USERS=`python -c "import requests
for u in requests.get('https://api.github.com/orgs/FOSSRIT/public_members').json():
    print u['login']"`

cd /home/gitback/gist_backups
for user in $USERS
do
    /home/gitback/github_backup/gist_backup.sh $user
done
