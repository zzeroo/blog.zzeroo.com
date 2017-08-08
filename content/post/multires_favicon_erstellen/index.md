---
title: "MultiRes Favicon erstellen"
date: 2017-08-08T13:25:43+02:00
draft: false
---

Ein [Favicon][favicon-wiki] ist ein kleines Bild. Es wird unter Anderem in Browsertabs, in der Adressleiste des Browsers oder als Symbol für ein Link der auf dem Bildschirm eures Telefons abgelegt wurde verwendet.

{{< figure src="./favicon-usage.png" title="Das kleine Flammen Logo ist ein Favicon, welches ich auf meinem Blog nutze." >}}

So genannte MultiRes [Favicon][favicon-wiki] sind `.ico` Icon Bilddateien in der verschiedene Versionen des selben Bildes gespeichert sind. Die Versionen unterscheiden sich in der Anzahl der Pixel die zur Darstellung des Symbols verwendet werden.

# MultiRes [Favicon][favicon-wiki] erstellen

Der folgende Befehl konvertiert das Bild `logo.png` in ein MultiRes [Favicon][favicon-wiki].
Dazu muss auf dem Rechner [ImageMagic][image-magic] installiert sein.

```bash
convert logo.png   -bordercolor white -border 0 \
      \( -clone 0 -resize 16x16 \) \
      \( -clone 0 -resize 32x32 \) \
      \( -clone 0 -resize 48x48 \) \
      \( -clone 0 -resize 64x64 \) \
      \( -clone 0 -resize 192x192 \) \
      -delete 0 -alpha off -colors 256 favicon.ico
```

Die original Datei `logo.png` ist 500x500 Pixel groß.

{{< figure src="./logo.png" title="500x500px" >}}

Nach dem `convert` Befehl erhaltet ihr eine Datei `favicon.ico`. Wenn ihr diese Datei mit [Gimp][gimp] öffnet, dann könnt ihr die verschieden Formate (Ebenen) erkennen.

{{< figure src="./favicon-in-gimp.png" title="in Gimp erkennt man die Ebenen" >}}


# Links

* [https://www.imagemagick.org](https://www.imagemagick.org)
* [https://de.wikipedia.org/wiki/Favicon](https://de.wikipedia.org/wiki/Favicon)
* [https://www.gimp.org/](https://www.gimp.org/)



[image-magic]: https://www.imagemagick.org/
[favicon-wiki]: https://de.wikipedia.org/wiki/Favicon
[gimp]: https://www.gimp.org/
