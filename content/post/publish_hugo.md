+++
date = "2017-07-09T21:53:25+02:00"
title = "Publish hugo on a Amazon AWS instance"
draft = true
+++

>This tutorial assumes that you have access via ssh to the remote (**prod**uction) server.

# Prepare the remote, production server
## Install `git`

```bash
sudo apt-get install git
```

## Install python and pip

```bash
sudo apt-get install python-pip
```

## Install Pygments

Now we use `pip` and install Pygments for syntax highlighting.

```bash
sudo pip install Pygments
```

# Install Hugo on the Production Server

For hugo we need `wget` and `curl`!

```bash
sudo apt-get install wget curl
```

```bash
curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep Linux-64bit.deb | xargs -I'{}' wget '{}'
```

```bash
sudo dpkg -i hugo*.deb
```


# remote git repo

First we have to create a bare (empty) git repo. It's a git-ish copy without data.

```bash
git clone --bare . /tmp/blog.zzeroo.com.git
```

Next we have to copy that bare, git repo to our remote server.
```bash
scp -r /tmp/blog.zzeroo.com.git/ zzeroo.com:
```

Back on the development maschine, add a remote with the name "prod" to your development git repo.

```bash
git remote add prod zzeroo.com:blog.zzeroo.com.git
```

And push the master to the remote (not nessesarry, but if that command fails, somthing goes wrong) as an test.

```bash
git push prod master
```

# git hook script

At this point we have our local, development git repository. And a remote git repo to which we can push our code changes.
The idea is now, if you push your local changes to the remote git repository, something magically should happen and copy the public part of your hugo repo to the htdocs of your apache2 installation.

This magic is called a git hook.

```bash
$ cat > hooks/post-receive
#!/bin/sh
GIT_REPO=$HOME/blog.zzeroo.com.git
WORKING_DIRECTORY=$HOME/blog.zzeroo.com-working
PUBLIC_WWW=/var/www/html
BACKUP_WWW=/var/www/html.backup
MY_DOMAIN=zzeroo.com

HUGO=`whereis hugo`

set -e
# if $WORKING_DIRECTORY is a `d`irectory `rm` it `r`ecursive and with `f`orce
[ -d $WORKING_DIRECTORY ] && rm -rf $WORKING_DIRECTORY
rsync -aqz $PUBLIC_WWW/ $BACKUP_WWW
trap "echo 'A problem occurred.  Reverting to backup.'; rsync -aqz --del $BACKUP_WWW/ $PUBLIC_WWW; rm -rf $WORKING_DIRECTORY" EXIT

git clone $GIT_REPO $WORKING_DIRECTORY
rm -rf $PUBLIC_WWW/*
$HUGO -s $WORKING_DIRECTORY -d $PUBLIC_WWW -b "http://${MY_DOMAIN}"
rm -rf $WORKING_DIRECTORY
trap - EXIT
^D
```

Before we can test the new hook-script we must ensure that we have the needed rights to write the files and folders. I use a very standard apache2 configuration for a single user system. My htdocs is located under `/var/www/html/`.  The next command ensures that the dir is ownd by the group `www-data` (standard apache2 working user).

```bash
sudo chgrp www-data /var/www -R
```

Next we ensure that the group `www-data` has read-write access

```bash
sudo chmod g=rwX /var/www -R
```

The last command add your remote, production user to the `www-data` group

```bash
sudo gpasswd -a smueller www-data
```


----


# Advance configuration

The default administrator user on amazon AWS instances is called `admin`. And the ssh access with plain passwords is not allowed. Instead of the good old plain password you have to submit a RSA Key via the ssh parameter `-i`.

```bash
# Example ssh login as admin user and with a RSA key
ssh admin@zzeroo.com -i ~/path/to/amazon-key.pem
```


## SSH config

http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/

```bash
# ~/.ssh/config
Host zzeroo.com
  User admin
  IdentityFile  "~/amazon-key.pem
```

[idea]: https://www.digitalocean.com/community/tutorials/how-to-deploy-a-hugo-site-to-production-with-git-hooks-on-ubuntu-14-04
[idea2]: http://caiustheory.com/automatically-deploying-website-from-remote-git-repository/