# Tutorium Grundlagen Datenbanken WS1819

## Kompilieren des PDF-Dokuments
Um aus den im Repository hinterlegten Latex-Dateien ein PDF-Dokument zu erzeugen wird ein Latex-Compilier benötigt.

Der Latex-Compiler kann manuell für jedes Betriebssystem installiert werden. Siehe Anleitung auf [latex-project.org](https://www.latex-project.org/get/).

Alternativ kann auch Docker verwendet werden um aus dem Sourcecode ein PDF-Dokument zu erzeugen.

```bash
$ docker run \
  --rm \
  --user="$(shell id -u):$(shell id -g)" \
  --net="none" \
  --volume="${PWD}:/data" volkerraschek/docker-latex:latest \
  make latexmk
```

## Editoren
Editoren mit integrierter PDF-Ansicht um aus Latex-Quellcode PDF-Dokumente zu erstellen.
+ Visual Studio Code + Plugin LaTex Workshop
+ Texstudio
