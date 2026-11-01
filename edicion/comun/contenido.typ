// Contenido hecho a mano (provisional): sustituye al `outline`, que solo conoce los
// pocos encabezados del libro. Cada entrada apunta a un encabezado (por etiqueta) o a
// una página impresa de Seitz (por número; se resuelve con las marcas `pag`).
//   (nivel: 1|2, titulo: [..], destino: <etiqueta> | n, romano: bool, seitz: "pp. 55–65")
// Las entradas cuyo destino no existe en esta compilación (índice, resumen) se omiten.
#import "aparato.typ": seitz as _seitz

#let _donde(destino) = {
  if type(destino) == label {
    let r = query(destino)
    if r.len() > 0 { r.first().location() } else { none }
  } else {
    let r = query(<seitz-pag>).filter(m => m.value == destino)
    if r.len() > 0 { r.first().location() } else { none }
  }
}

#let contenido(entradas) = context {
  set par(first-line-indent: 0pt, hanging-indent: 0pt, justify: false)
  for e in entradas {
    let loc = _donde(e.destino)
    if loc == none { continue }
    let n = counter(page).at(loc).first()
    let folio = numbering(if e.at("romano", default: false) { "i" } else { "1" }, n)
    let nivel = e.at("nivel", default: 1)
    block(above: if nivel == 1 { 1.1em } else { 0.45em }, below: 0em, breakable: false,
      pad(left: 1.6em * (nivel - 1), link(loc)[
        #e.titulo
        #if e.at("seitz", default: none) != none [#h(0.4em)#text(size: 0.85em, fill: luma(40%))[(Seitz, #e.seitz)]]
        #box(width: 1fr, repeat[#h(0.2em).#h(0.2em)])
        #folio
      ]))
  }
}
