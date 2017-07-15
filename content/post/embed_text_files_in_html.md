+++
date = "2017-07-10T09:05:29+02:00"
title = "Text Datei in HTML einbetten"
draft = false
+++

Für meine Homepage hatte ich nach einer Möglichkeit gesucht meine [PGP Key's][homepage], als ASCII Exports, einzubinden. Auf [Stackoverflow][stackoverflow] bin ich mal wieder fündig geworden. 

Die dort vorgeschlage Lösung arbeitet ganz ohne Javascript Ticks, rein mit HTML5 und etwas CSS.

Zunächst habe ich meinen GPG Key exportiert. Der Parameter `--armor` sorgt dafür das nur ASCII Zeichen für die Darstellung des Schlüssels verwendet werden. 

```bash
gpg --armor --export --output co@zzeroo.com.gpg.txt co@zzeroo.com
```

Diesen Schlüssel habe ich dann im htdocs meines Webservers gespeichert.
Mit dem folgenden HTML kann der Schlüssel dann in die Webseite eingebunden werden. Wichtig ist das `<object></object>` HTML Tag. Der `<a></a>` Link den die `<object></object>` Tags umschließen dient als Fallback Lösung. Für den Fall das der Webbrowser die `<object></object>` Tags nicht darstellen kann.

```html
<object data="co@zzeroo.com.gpg.txt" type="text/plain" width="500" style="height: 300px">
    <a href="co@zzeroo.com.gpg.txt">co@zzeroo.com.gpg.txt</a>
</object>
```

Das ganze funktioniert mit jedem beliebigen Text Dateien. Die Dateiendung scheint aber wichtig zu sein. Ich hatte bei einem Versuch die Dateiendung `.ascii` für meinen Schlüssel verwendet. Das hatte bei mehr als einer Einbindung pro Webseite den Effekt dass immer nur eine Datei dargestellt wurde.

[homepage]: https//zzeroo.com
[stackoverflow]: https://stackoverflow.com/questions/19324301/embed-text-files-in-html#answer-19324413