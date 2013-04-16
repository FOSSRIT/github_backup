#!/bin/bash
set -e

cd $1
GITBACKPATH=/usr/local/bin/github_backup

USERS=`python -c "import requests
for u in requests.get('https://api.github.com/orgs/FOSSRIT/public_members').json():
    print u['login']"`

for user in $USERS
do
    $GITBACKPATH $user
done

$GITBACKPATH FOSSRIT org
