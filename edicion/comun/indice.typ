// Índice de la edición: `indexar` imprime el texto y apunta una entrada con la
// página impresa de Seitz en curso; `indice` compone el índice de una categoría.
#import "aparato.typ": seitz

#let entradas = state("indice", ())

#let indexar(cat, nombre, cuerpo) = {
  cuerpo
  context {
    let p = seitz.get()
    entradas.update(a => a + ((cat, nombre, p),))
  }
}

// Orden alfabético sin acentos
#let _clave(s) = {
  let t = lower(s)
  for (a, b) in (("á", "a"), ("é", "e"), ("í", "i"), ("ó", "o"), ("ú", "u"), ("ñ", "n"), ("ü", "u")) {
    t = t.replace(a, b)
  }
  t
}

#let indice(cat) = context {
  let todas = entradas.final().filter(e => e.at(0) == cat)
  let nombres = todas.map(e => e.at(1)).dedup().sorted(key: _clave)
  set par(first-line-indent: 0pt, hanging-indent: 1em, justify: false)
  set text(size: 0.92em)
  columns(2, gutter: 1.2em)[
    #for n in nombres {
      let pags = todas.filter(e => e.at(1) == n).map(e => e.at(2)).filter(p => p > 0).dedup().sorted()
      [#n, #pags.map(str).join(", ") \ ]
    }
  ]
}
