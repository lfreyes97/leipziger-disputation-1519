// Tabla de siglas del Resumen de IA, formateada a mano (docs/RESUMEN-IA.md, tabla 1).
// Si cambia el contenido de la tabla en el .md, hay que actualizarlo aquí.
#let cab(t) = text(font: ("EB Garamond SC 12", "Libertinus Serif"), tracking: 0.04em, t)
#let nota(t) = text(size: 0.92em, t)

#block(breakable: true, above: 1em, below: 1em, {
  set par(justify: false, first-line-indent: 0pt, hanging-indent: 0pt)
  set text(size: 0.95em)
  table(
    columns: (2.6cm, 1fr),
    stroke: none,
    inset: (x: 6pt, y: 5pt),
    align: (left + top, left + top),
    table.header(
      table.hline(stroke: 0.9pt),
      cab[Sigla], cab[Fuente],
      table.hline(stroke: 0.5pt),
    ),
    [P], [#emph[Protokolldruck]: impreso del protocolo llevado por los notarios (92 hojas en 4.º). Fuente base para el tramo Lutero–Eck.],
    [M], [Manuscrito de Freiberg: apunte tomado al dictado durante la propia disputa (descrito por Brieger, 1896).],
    [U], [#emph[Urdruck] de 1519: impresión que sirvió de base a todas las ediciones anteriores; apunte privado de un testigo presencial.],
    [Uv], [Ejemplar de U con correcciones manuscritas de una mano coetánea.],
    [Mc], [Mano(s) correctora(s) de M. #nota[\[Interpretación editorial a partir del uso en el aparato; no definida como tal en las pp. 1–11 de Seitz.\]]],
    [Lö], [Löscher, #emph[Vollständige Reformations-Acta und Documenta], III (Leipzig, 1729).],
    [R. / a. R.], [#emph[Am Rande]: lectura o nota al margen (p. ej. «U a. R.», «Mc a. R.»). #nota[\[Interpretación editorial; Seitz no define una sigla «R.» aislada en las pp. 1–11.\]]],
    [W. A.], [Weimarer Ausgabe, #emph[D. Martin Luthers Werke], Abt. I, vol. II: texto de contraste y localizador de pasajes.],
    table.hline(stroke: 0.9pt),
  )
})
