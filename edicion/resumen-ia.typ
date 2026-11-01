// Resumen de IA (documento suelto) — fuente: docs/RESUMEN-IA.md
// Compilar: scripts/construir.sh resumen
#set document(title: "Resumen de IA — El debate de Lutero con Eck (Leipzig, 1519)")
#set page(paper: "a4", margin: (x: 3cm, y: 2.5cm), numbering: "1")
#set text(font: ("EB Garamond 12", "Libertinus Serif"), lang: "es", size: 12pt)
#set par(justify: true, first-line-indent: 1.2em, spacing: 0.7em)
#set smartquote(enabled: false)
#show heading: set text(font: "IM FELL English", weight: "regular")
#show heading.where(level: 1): set text(size: 1.5em)
#show heading: set block(above: 1.4em, below: 0.8em)

#align(center)[
  #text(font: "IM FELL English", size: 1.8em)[Resumen de IA] \
  #text(size: 1.15em)[El debate de Lutero con Eck (Leipzig, 1519)] \
  #v(0.3em)
  #text(size: 0.9em, style: "italic")[Elaborado con IA a partir de la edición de Seitz (1903, pp. 55--218). No procede de Seitz y no ha sido verificado ni revisado por una persona.]
]
#v(1em)

#include "fragmentos/resumen.typ"
