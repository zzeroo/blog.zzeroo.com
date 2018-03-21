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

Offensichtlich muss der Key dazu auf dem Keyserver verfügbar sein. Das ist für große bekannte Repos sehr oft der Fall, kann aber auch nicht sein. Desshalb gibt es noch den "etwas längeren Weg".

# etwas längerer Weg

Diese Lösung finde ich persönlich nicht so schön, da hier mehrere Befehle zusammen ausgeführt werden müssen (wo soll ich `sudo` aufrufen, vor oder hinter der Pipe `|`, dass ist am Anfang immer mal die Frage?). Funktional ist sie aber nicht schlechter oder besser.

```bash
wget -q https://url/zum/Release.key -O- | sudo apt-key add -
sudo apt-get update
```

Bei diesem Befehl wird der Schlüssel explizit von einer URL herunter geladen. Diese Befehle müssen genutzt werden wenn der Public Key nicht auf einem Schlüsselserver veröffentlicht wurde. Bei kleineren Projekten, oder Projekten mit besonderen Sicherheitsansprüchen oft der Fall.

[Update] 2018-03-21 12:00:00

# Mögliche Fehler
## Fehler: `gpg: keyserver receive failed: No dirmngr`

In einer default debian:9 Installation erscheint nach dem Befehl `sudo apt-key adv --keyserver keys.gnupg.net --recv-key 0x12345678` die Meldung `gpg: keyserver receive failed: No dirmngr`.

## Lösung: `gpg: keyserver receive failed: No dirmngr`

Die Lösung ist denkbar einfach. Einfach `dirmngr` mit dem Packetmanager nachinstallieren:

```bash
apt install dirmngr
```
