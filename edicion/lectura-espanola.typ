// Edición de LECTURA española — Disputa Lutero-Eck (Seitz 1903, impresas 55-218)
// Sin aparato crítico (véanse edicion-latina.typ y edicion-espanola.typ).
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts lectura-espanola.typ
#import "comun/lib.typ": *

#show: edicion.with(
  "Disputa de Leipzig (1519)",
  [Debate de Lutero con Eck (4--14 de julio) · Edición de lectura · traducción española],
  lang: "es",
  nota: [
    Alcance: solo el debate de Lutero con Eck; el resto de la Disputa de Leipzig no está incluido. Traducción para lectura seguida: se suprime el aparato crítico y las
    llamadas; los oradores van como encabezados y las referencias de actas
    \[NNN\] en gris, en línea. Para el texto crítico bilingüe, véanse las
    ediciones latina y española.
  ],
)

#include "fragmentos/lectrad1.typ"
#include "fragmentos/lectrad2.typ"
#include "fragmentos/lectrad3.typ"
