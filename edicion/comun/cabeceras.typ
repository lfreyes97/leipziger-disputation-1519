// Cabecera y pie de las ediciones. Sustituyen a los de documentclass, que solo
// muestran cabecera cuando hay partes (aquí no las hay). Texto de 9 pt; en cada
// línea, lo propio de la página en el lado interior y el folio / las páginas de
// Seitz en el exterior, alternando recto y verso:
//   recto (impar):  cabecera |capítulo en curso ........ Seitz, pp. 61–63|
//                   pie      |último orador de la página ........ folio|
//   verso (par):    cabecera |Seitz, pp. 61–63 ........ título de la obra|
//                   pie      |folio ........ último orador de la página|
// Sin cabecera: páginas sin numeración (portada, legales) y la primera de cada capítulo.
// Las páginas de Seitz y el orador solo aparecen en el texto.
#import "aparato.typ": seitz
#import "paginas.typ": pagina-en-blanco

#let cabeceras(titulo, cuerpo) = {
  let fuente = ("EB Garamond SC 12", "Libertinus Serif")
  let tam = 9pt
  // dos piezas en una línea: la primera pegada a la izquierda, la segunda a la derecha
  let linea(a, b) = box(width: 100%, [#a #h(1fr) #b])
  set page(
    header: context {
      let p = here().page()
      if page.numbering == none or pagina-en-blanco(here().page()) { return none }
      let caps = query(heading.where(level: 2))
      if caps.any(h => h.location().page() == p) { return none }
      let previos = caps.filter(h => h.location().page() < p)
      let cap = if previos.len() > 0 { previos.last().body } else { titulo }
      // páginas de Seitz de esta página: la vigente al empezar y las marcadas en ella
      let ini = seitz.get()
      let marcas = query(<seitz-pag>).filter(m => m.location().page() == p).map(m => m.value)
      let fin = if marcas.len() > 0 { marcas.last() } else { ini }
      let pags = if ini > 0 {
        if ini == fin [Seitz, p. #ini] else [Seitz, pp. #ini\–#fin]
      } else { [] }
      set text(font: fuente, size: tam, tracking: 0.04em)
      if calc.odd(p) { linea(cap, pags) } else { linea(pags, titulo) }
    },
    footer: context {
      if page.numbering == none or pagina-en-blanco(here().page()) { return none }
      let p = here().page()
      let folio = counter(page).display(page.numbering)
      // último orador de la página: el último que entra en ella o, si no entra ninguno, el que continúa
      let fin = query(<fin-texto>)
      let en-texto = fin.len() == 0 or fin.first().location().page() >= p
      let marcas = query(<orador>)
      let hasta-aqui = marcas.filter(m => m.location().page() <= p)
      let orador = if en-texto and hasta-aqui.len() > 0 { hasta-aqui.last().value } else { [] }
      set text(font: fuente, size: tam, tracking: 0.04em)
      if calc.odd(p) { linea(orador, folio) } else { linea(folio, orador) }
    },
  )
  cuerpo
}
