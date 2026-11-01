// Edición de LECTURA española — Disputa Lutero-Eck (Seitz 1903, impresas 55-218)
// Sin aparato crítico (véanse edicion-latina.typ y edicion-espanola.typ).
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts lectura-espanola.typ
#import "lib.typ": *

#show: edicion.with(
  "Disputa de Leipzig (1519)",
  [II. Lutero--Eck · Edición de lectura · traducción española],
  lang: "es",
  nota: [
    Traducción para lectura seguida: se suprime el aparato crítico y las
    llamadas; los oradores van como encabezados y las referencias de actas
    \[NNN\] en gris, en línea. Para el texto crítico bilingüe, véanse las
    ediciones latina y española.
  ],
)

#include "lectrad1.typ"
#include "lectrad2.typ"
#include "lectrad3.typ"
