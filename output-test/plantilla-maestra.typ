// Plantilla maestra — Seitz 1903, II. Disputatio Luther-Eck (prueba pp. 55-64)
// Compilar: typst compile plantilla-maestra.typ
#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
#set text(font: "Libertinus Serif", lang: "la", size: 11pt)
#set par(justify: true, leading: 0.65em, first-line-indent: 1.2em)
#show footnote.entry: set text(size: 9pt)
#show footnote.entry: set par(first-line-indent: 0em)

#align(center, text(17pt, weight: "bold")[Der authentische Text der Leipziger Disputation (1519)])
#align(center, text(13pt)[II. Disputatio Luther–Eck (Seitz 1903, pp. 55–64, prueba)])
#align(center, text(10pt, style: "italic")[Fuente: test pp. 1–10. Fragmentos sin `\#set`, ensamblados por `\#include`.])
#v(1em)

#include "test-p01.typ"
#include "test-p01b.typ"
#include "test-p02.typ"
#include "test-p03.typ"
#include "test-p04.typ"
#include "test-p05.typ"
// Siguientes fragmentos: #include "test-p06.typ" etc., sin saltos forzados.
