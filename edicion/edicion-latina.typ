// Edición latina (crítica, con aparato) — Seitz 1903, II. Disputatio Luther-Eck (impresas 55-218)
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts edicion-latina.typ
#import "lib.typ": *

#show: edicion.with(
  "Der authentische Text der Leipziger Disputation",
  [II. Disputatio Luther--Eck (4--14 de julio de 1519)],
  lang: "la",
  nota: [
    Transcripción diplomática de Seitz, impresas 55--218, página por página y
    con el aparato crítico íntegro (siglas M U Uv Mc Lö P R.); u/v, i/j y
    puntuación originales; \[...\] = ilegible; \[NNN\] = referencias del
    impreso. Las notas llevan la etiqueta del impreso. Anomalías documentadas
    en #raw("docs/RESOLUCIONES.md").
  ],
)

#include "lote1.typ"
#include "lote2.typ"
#include "lote3.typ"
