---
name: latex-document
description: Verwende diesen Skill fuer LaTeX-Dokumente mit professioneller Struktur und lesbarem Layout. Nutze ihn fuer neue .tex-Dateien, Ueberarbeitung bestehender Dokumente, Tabellen, Abbildungen, Gleichungen, Literaturverwaltung und LaTeX-Fehlerbehebung.
---

# LaTeX Document

## Leitprinzip

- Inhalt vor Ornamentik.
- Struktur vor Sichtbarkeit.
- Nur genutzte Pakete im Vorspann.
- Keine unnötige Komplexitaet.

## Vorgehen

1. Dokumenttyp bestimmen (Article, Report, Thesis, Letter, Vortrag).
2. Bestehende Projektstandards uebernehmen (Klasse, Preamble, Konventionen).
3. Klare Hierarchie aufbauen:
   - `\title`, `\author`, `\date`
   - `\section`, `\subsection`, `\label`, `\ref`
   - konsistente Referenzpraefixe (`sec:`, `fig:`, `tab:`, `eq:`).
4. Text in kurze, nachvollziehbare Blöcke gliedern.
5. Tabellen/Abbildungen mit Beschriftung und Verweisen platzieren.
6. Mathematische Ausdruecke konsistent einsetzen.
7. Bei Fehlern die kleinste stabile Korrektur liefern.

## Kompakte Basispraeambel

```latex
\documentclass[11pt,a4paper]{article}
\usepackage[T1]{fontenc}
\usepackage[ngerman]{babel}
\usepackage{microtype}
\usepackage{amsmath,amssymb}
\usepackage{graphicx}
\usepackage{booktabs}
\usepackage[hidelinks]{hyperref}
\title{Titel}
\author{Autor}
\date{\today}
```

LaTeX verarbeitet UTF-8 seit 2018 standardmaessig. Bei LuaLaTeX oder XeLaTeX `fontspec` benutzen und `fontenc` weglassen.

## Typografische Regeln

- `booktabs` fuer saubere Tabellen; keine vertikalen Linien.
- Keine `\\` als Abschnittstrenner.
- Klare Überschriften, keine leeren Etiketten ("Details", "Weitere Infos").
- `\emph{}` fuer Hervorhebung statt ueberschaubarer Sonderformatierungen.
- Jede Grafik und jede Tabelle sofort im Text einordnen.

## Dokumentaufbau

- Einleitung: Ziel und Problem.
- Hauptteil: Vorgehen, Befund, Herleitung.
- Schluss: Kernaussagen und Grenzen.
- Literatur: konsistent und nach Projektstandard.

## Ausgabe-Verhalten

- Neuanlage: vollständige minimal funktionsfähige `.tex`-Datei.
- Bestehende Datei: gezielten Patch oder ersetztes Teilmodul liefern.
- Fehlersuche: Ursache + kleinster kompiliersicherer Fix.
