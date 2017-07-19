---
title: "Apt GPG Keys beibringen"
date: 2017-07-19T12:40:38+02:00
---

Weil ich es immer wieder vergesse hier nocheinmal einige Wege wie man dem Apt GPG Keys beibringt.

# der schöne Weg

Mein bevorzugter Befehl ist der folgende. Hier wird mit einem Befehl der GPG Key von einem Keyserver herunter geladen und in Apt gespeichert.

```bash
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 0x12345678
sudo apt-get update
```

Offensichtlich muss der Key dazu auf dem Keyserver verfügbar sein. Das ist für große bekannte Repos sehr oft der Fall, kann aber auch nicht sein. Desshalb gibt es noch portablen Weg.

# der portable Weg

Diese Lösung finde ich persönlich nicht so schön, da hier der Schlüssel ins aktuelle Verzeichnis geladen wird. Und mehrere Befehle zusammen ausgeführt werden müssen (wo soll ich `sudo` aufrufen, ist am Anfang immer mal die Frage?)


```bash
wget -q https://url/zum/Release.key -O- | sudo apt-key add -
sudo apt-get update
```


