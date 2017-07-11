+++
date = "2017-07-09T22:30:13+02:00"
title = "Used Tech"

+++

# Hugo

## Download 

```bash
curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep Linux-64bit.deb | xargs -I'{}' wget '{}'
```

# CSS

https://purecss.io/

## Download 

```bash
curl -s https://api.github.com/repos/yahoo/pure/releases/latest | grep zipball_url | cut -d '"' -f 4  | xargs -I'{}' wget '{}'
```

# Syntax highlight

http://prismjs.com/index.html

