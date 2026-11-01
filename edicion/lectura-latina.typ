// Edición de LECTURA latina — Disputa Lutero-Eck (Seitz 1903, impresas 55-218)
// Sin aparato crítico (véase edicion-latina.typ).
// Compilar: typst compile --ignore-system-fonts --font-path ~/Projects/Instatypst/Fonts lectura-latina.typ
#import "comun/lib.typ": *

#show: edicion.with(
  "Disputa de Leipzig (1519)",
  [Debate de Lutero con Eck (4--14 de julio) · Edición de lectura · texto latino],
  lang: "la",
  nota: [
    Alcance: solo el debate de Lutero con Eck; el resto de la Disputa de Leipzig no está incluido. Texto para lectura seguida: se suprime el aparato crítico y las llamadas;
    los oradores van como encabezados y las referencias de actas \[NNN\] en
    gris, en línea. Para el texto crítico, véase la edición latina.
  ],
)

#include "fragmentos/lec1.typ"
#include "fragmentos/lec2.typ"
#include "fragmentos/lec3.typ"
