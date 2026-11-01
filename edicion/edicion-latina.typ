// Edición latina (crítica, con aparato) — Seitz 1903, II. Disputatio Luther-Eck (impresas 55-218)
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts edicion-latina.typ
#import "comun/lib.typ": *

#show: edicion.with(
  "Disputa de Leipzig (1519)",
  [Debate de Lutero con Eck (4--14 de julio) · Texto latino con aparato crítico],
  lang: "la",
  nota: [
    Alcance: solo el debate de Lutero con Eck; el resto de la Disputa de Leipzig no está incluido. Transcripción diplomática de Seitz, impresas 55--218, página por página y
    con el aparato crítico íntegro (siglas M U Uv Mc Lö P R.); u/v, i/j y
    puntuación originales; \[...\] = ilegible; \[NNN\] = referencias del
    impreso. Las notas llevan la etiqueta del impreso. Anomalías documentadas
    en #raw("docs/RESOLUCIONES.md").
  ],
)

#include "fragmentos/lote1.typ"
#include "fragmentos/lote2.typ"
#include "fragmentos/lote3.typ"
