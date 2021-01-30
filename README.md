# Tutorium Grundlagen Datenbanken WS1819

[![Build Status](https://drone.cryptic.systems/api/badges/fh-trier/tgdb_ws1819l/status.svg)](https://drone.cryptic.systems/fh-trier/tgdb_ws1819l)

## SQL

Das Schema kann mittels `make db/import-model` geladen werden. Dazu müssen
allerdings die Umgebungsvariablen `DB_HOST`, `DB_USER` und `DB_PASSWD`
gesetzt sein.

Mit dem Parameter `make db/execute-solutions` werden alle Dateien innerhalb des
Ordners `uebungen` auf der Datenbank ausgeführt. Möchte man einen Unterordner
explizit ausführen kann die Variable `FOLDER` gesetzt werden. Hier ein Beispiel
`make execute-solutions FOLDER=uebung_05`.

## Latex

Um aus den im Repository hinterlegten Latex-Dateien ein PDF-Dokument zu erzeugen
wird ein Latex-Compilier benötigt. Der Latex-Compiler kann manuell für jedes
Betriebssystem installiert werden. Siehe Anleitung auf
[latex-project.org](https://www.latex-project.org/get/).

Alternativ kann auch Docker verwendet werden um aus dem Sourcecode ein
PDF-Dokument zu erzeugen. Dazu der folgende Befehl:

```bash
$ docker run \
  --rm \
  --user="$(shell id -u):$(shell id -g)" \
  --net="none" \
  --volume="${PWD}:/workspace" volkerraschek/container-latex:latest-archlinux \
  make
```

## Editoren

+ Visual Studio Code \
  Geeignet für die Entwicklung vieler Programmiersprachen als auch für das
  Schreiben von Latex und SQL-Dateien.
  + Plugin: LaTex Workshop
  + Plugin: PL/SQL
+ Texstudio \
  Ausschließlich geeignet für das Schreiben von Latex-Dokumenten.
