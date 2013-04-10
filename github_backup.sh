#!/bin/bash
set -e

if [ -z $2 ]
then
        TYPE=users
else
        TYPE=orgs
fi

if [ -z $1 ]
then
        echo "Need to specify Github Username to back up."
        echo "Usage:
        github_backup <username>
        github_backup <organization name> org"
        exit 1
else
        echo "Backing up $1's git repos"
        if [ ! -d $1 ]
        then
                mkdir $1
        fi
        cd $1
fi
REPOLIST=`python -c "import requests
for repo in requests.get('https://api.github.com/$TYPE/$1/repos').json():
        print repo['git_url']"`

for R in $REPOLIST
do
        if [ -d `echo $R | sed -e 's/.*\/\([^/]\)/\1/'` ]
        then
                echo "Already have $R saved"
        else
                git clone --mirror $R
                echo "Backed up $R"
        fi
done

for N in `ls`
do
        cd $N
        git fetch -q
        cd ..
        echo "Updated $N"
done
