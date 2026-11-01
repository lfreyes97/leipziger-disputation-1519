// Aspecto de los encabezados de las ediciones. Sustituye al de documentclass,
// que no distingue las intervenciones de los oradores ni deja un contorno útil.
//   nivel 2: capítulo (parte del libro)      nivel 3: sección («II.»)
//   nivel 4: intervención de un orador
#import "aparato.typ": estilo-orador

#let titulos(cuerpo) = {
  show heading.where(level: 3): it => block(above: 2em, below: 1em, sticky: true,
    align(center, text(font: "IM FELL English", size: 1.4em, weight: "regular", it.body)))
  show heading.where(level: 4): it => estilo-orador(it.body)
  cuerpo
}
