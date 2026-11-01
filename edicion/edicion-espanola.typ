// Edición española (crítica, con aparato) — Seitz 1903, II. Disputatio Luther-Eck (impresas 55-218)
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts edicion-espanola.typ
#import "comun/lib.typ": *

#show: edicion.with(
  "Disputa de Leipzig (1519)",
  [Debate de Lutero con Eck (4--14 de julio) · Traducción española con aparato crítico],
  lang: "es",
  nota: [
    Alcance: solo el debate de Lutero con Eck; el resto de la Disputa de Leipzig no está incluido. Traducción al español de Seitz, impresas 55--218, cuerpo a cuerpo con la
    transcripción latina. El aparato crítico se conserva en su lengua original
    (latín y alemán; siglas M U Uv Mc Lö P R.). Las notas llevan la etiqueta
    del impreso. Anomalías documentadas en #raw("docs/RESOLUCIONES.md").
  ],
)

#include "fragmentos/trad1.typ"
#include "fragmentos/trad2.typ"
#include "fragmentos/trad3.typ"
