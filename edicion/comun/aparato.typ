// Piezas del aparato compartidas por los fragmentos generados (sin dependencias).

// Nota con la etiqueta ORIGINAL del impreso (14, 2a, e3…): la llamada y la
// entrada del pie llevan la misma etiqueta, no un número correlativo.
#let apnota(etiqueta, cuerpo) = footnote(numbering: _ => etiqueta + ")", cuerpo)

// Referencia del impreso ([255], [W. A. 254]…) en la edición de lectura.
#let refimp(n) = text(size: 0.72em, fill: luma(45%))[\[#n\]]

// Intervención de un orador (edición de lectura).
#let orador(nombre) = block(above: 1.4em, below: 0.5em, sticky: true,
  text(style: "italic", weight: "bold")[#nombre])
