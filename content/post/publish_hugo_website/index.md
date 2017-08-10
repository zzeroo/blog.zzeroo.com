---
title: "Hugo Website veröffentlichen"
date: 2017-04-20T12:00:33+02:00
draft: true
---

* local: remote root access via ssh `username@hostname.tld` without password `vim ~/.ssh/config`
* remote: Repo erstellen `git init --bare --shared hugo.hostname.tld.git`
* remote: post-receive hook erstellen
```bash
# cat hugo.hostname.tld.git/hooks/post-receive
#!/bin/sh

# Name and path of the git repo
GIT_REPO=$HOME/hostname.tld.git
# Name of a working directory
WORKING_DIRECTORY=$HOME/hostname.tld-working
# Where should the website be published
PUBLIC_WWW=/var/www/html
# and where sould be the backup
BACKUP_WWW=/var/www/html.backup
# Your domain name, this information is later for hugo (parameter: `-b`)
MY_DOMAIN=hostname.tld

# find hugo executable and store path in $HUGO variable
HUGO=`which hugo`
# exit script on errors
set -e
# the following script can be translated to:
#   if $WORKING_DIRECTORY is a `d`irectory `rm` it `r`ecursive and with `f`orce
[ -d $WORKING_DIRECTORY ] && rm -rf $WORKING_DIRECTORY
# backup www dir
rsync -aqz $PUBLIC_WWW/ $BACKUP_WWW
# action on error, restore backup of www dir
trap "echo 'A problem occurred.  Reverting to backup.'; rsync -aqz --del $BACKUP_WWW/ $PUBLIC_WWW; rm -rf $WORKING_DIRECTORY" EXIT

# Now clone the content of the git repo to the www dir
git clone $GIT_REPO $WORKING_DIRECTORY
# remove the preveous website version
rm -rf $PUBLIC_WWW/*
# generate with hugo the new website
$HUGO -s $WORKING_DIRECTORY -d $PUBLIC_WWW -b "https://${MY_DOMAIN}/"
# clean up the working dir
rm -rf $WORKING_DIRECTORY
trap - EXIT
```
* local: `git remote add prod username@hostname.tld:hugo.hostname.tld.git`
* local: `git push prod master`
