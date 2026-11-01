// Piezas compartidas por los fragmentos generados (sin dependencias del resto).

// Nota con la etiqueta ORIGINAL del impreso (14, 2a, e3…): la llamada y la
// entrada del pie llevan la misma etiqueta, no un número correlativo.
#let apnota(etiqueta, cuerpo) = footnote(numbering: _ => etiqueta + ")", cuerpo)

// Referencia del impreso ([255], [W. A. 254]…) en la edición de lectura.
#let refimp(n) = text(size: 0.72em, fill: luma(45%))[\[#n\]]

// Página impresa de Seitz en curso: la fija `pag` y la lee el índice.
#let seitz = state("seitz", 0)

// Marca de comienzo de página impresa: actualiza `seitz` y pone el número en
// el margen (no ocupa línea ni altera el texto).
#let pag(n) = {
  seitz.update(n)
  place(left, dx: -1.9cm, box(width: 1.5cm, align(right,
    text(size: 0.72em, fill: rgb("#9a1f17"), number-type: "lining")[#n])))
}

// Encabezados reales (aparecen en el contorno del PDF); su aspecto lo fija
// `comun/titulos.typ`. Nivel 3: sección; nivel 4: intervención de un orador.
#let seccion(cuerpo, pagina: none) = heading(level: 3, numbering: none, outlined: true)[
  #if pagina != none [#pag(pagina)]#cuerpo]
// Aspecto de la etiqueta de orador (lo usa también `titulos.typ`).
#let estilo-orador(cuerpo) = block(above: 1.4em, below: 0.6em, sticky: true, width: 100%,
  align(center, text(font: ("EB Garamond SC 12", "Libertinus Serif"), size: 1.2em, tracking: 0.03em, cuerpo)))
// Misma etiqueta, sin ser encabezado: para las que llevan llamada de nota (el
// texto de la nota acabaría en el contorno del PDF).
#let oradornota(cuerpo, pagina: none) = estilo-orador[#if pagina != none [#pag(pagina)]#cuerpo]
#let orador(cuerpo, pagina: none) = heading(level: 4, numbering: none, outlined: true)[
  #if pagina != none [#pag(pagina)]#cuerpo]
