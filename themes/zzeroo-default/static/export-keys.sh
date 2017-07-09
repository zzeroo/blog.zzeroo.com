#!/usr/bin/env bash

gpg --armor --export --output s.mueller@it.kls-glt.de.gpg.ascii s.mueller@it.kls-glt.de
gpg --export --output s.mueller@it.kls-glt.de.gpg s.mueller@it.kls-glt.de

gpg --armor --export --output co@zzeroo.com.gpg.ascii co@zzeroo.com
gpg --export --output co@zzeroo.com.gpg co@zzeroo.com
