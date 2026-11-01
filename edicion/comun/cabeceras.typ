// Cabecera y pie de las ediciones. Sustituyen a los de documentclass, que solo
// muestran cabecera cuando hay partes (aquí no las hay). Todo centrado.
//   cabecera, página par:   título de la obra
//   cabecera, página impar: capítulo en curso · «Seitz, pp. 57–58» (en el texto)
//   pie: folio (los arábigos del texto, los romanos del preliminar)
// Sin cabecera: páginas sin numeración (portada, legales) y la primera de cada capítulo.
#import "aparato.typ": seitz

#let cabeceras(titulo, cuerpo) = {
  let fuente = ("EB Garamond SC 12", "Libertinus Serif")
  set page(
    header: context {
      let p = here().page()
      if page.numbering == none { return none }
      let caps = query(heading.where(level: 2))
      if caps.any(h => h.location().page() == p) { return none }
      let previos = caps.filter(h => h.location().page() < p)
      let texto = if calc.even(p) {
        titulo
      } else {
        let cap = if previos.len() > 0 { previos.last().body } else { titulo }
        // páginas de Seitz que ocupa esta página: la vigente al empezar y las marcadas en ella
        let ini = seitz.get()
        let marcas = query(<seitz-pag>).filter(m => m.location().page() == p).map(m => m.value)
        let fin = if marcas.len() > 0 { marcas.last() } else { ini }
        if ini > 0 {
          [#cap · Seitz, #if ini == fin [p. #ini] else [pp. #ini\–#fin]]
        } else { cap }
      }
      set text(font: fuente, size: 0.95em, tracking: 0.04em)
      align(center, texto)
    },
    footer: context {
      if page.numbering == none { return none }
      let p = here().page()
      // oradores de esta página: el que habla al empezar (si continúa) y los que entran en ella
      let fin = query(<fin-texto>)
      let en-texto = fin.len() == 0 or fin.first().location().page() >= p
      let marcas = query(<orador>)
      let previos = marcas.filter(m => m.location().page() < p)
      let aqui = marcas.filter(m => m.location().page() == p)
      let lista = (if previos.len() > 0 { (previos.last(),) } else { () }) + aqui
      let nombres = lista.map(m => m.value).fold((), (acc, n) => if acc.len() > 0 and acc.last() == n { acc } else { acc + (n,) })
      set text(size: 0.95em)
      align(center, {
        if en-texto and nombres.len() > 0 {
          text(font: fuente, tracking: 0.04em, nombres.join([ · ]))
          linebreak()
        }
        counter(page).display(page.numbering)
      })
    },
  )
  cuerpo
}
