// Aspecto de los encabezados de las ediciones. Sustituye al de documentclass,
// que no distingue las intervenciones de los oradores ni deja un contorno útil.
// Siempre centrados y algo mayores que el cuerpo:
//   nivel 2: capítulo (1.5em, siempre en página impar)   nivel 3: sección, p. ej. «II.» (1.3em)
//   nivel 4: intervención de un orador (1.2em, versalitas de EB Garamond; ver aparato.typ)
#import "aparato.typ": estilo-orador
#import "paginas.typ": salto-impar

#let titulos(cuerpo) = {
  show heading.where(level: 2): it => {
    salto-impar()
    v(2.5em)
    block(below: 1.5em, align(center, text(font: "IM FELL English", size: 1.5em, weight: "regular", it.body)))
  }
  show heading.where(level: 3): it => block(above: 2em, below: 1em, sticky: true, width: 100%,
    align(center, text(font: "IM FELL English", size: 1.3em, weight: "regular", it.body)))
  show heading.where(level: 4): it => estilo-orador(it.body)
  cuerpo
}
