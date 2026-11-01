// Edición española (crítica, con aparato) — Seitz 1903, II. Disputatio Luther-Eck (impresas 55-218)
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts edicion-espanola.typ
#import "lib.typ": *

#show: edicion.with(
  "El texto auténtico de la Disputa de Leipzig",
  [II. Disputa Lutero--Eck (4--14 de julio de 1519)],
  lang: "es",
  nota: [
    Traducción al español de Seitz, impresas 55--218, cuerpo a cuerpo con la
    transcripción latina. El aparato crítico se conserva en su lengua original
    (latín y alemán; siglas M U Uv Mc Lö P R.). Las notas llevan la etiqueta
    del impreso. Anomalías documentadas en #raw("docs/RESOLUCIONES.md").
  ],
)

#include "trad1.typ"
#include "trad2.typ"
#include "trad3.typ"
