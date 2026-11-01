// Composición común de las cuatro ediciones (crítica y lectura, latina y española).
// Requiere @local/documentclass y @local/instatypst (portada y legales).
// Sin portada ni legales: typst compile --input portada=no …
#import "@local/documentclass:0.1.0": book, front, main, back, half-title
#import "aparato.typ": apnota
#import "titulos.typ": titulos
#import "indice.typ": indice
#import "cabeceras.typ": cabeceras
#import "paginas.typ": en-blanco
#import "contenido.typ": contenido
#import "../contenido-entradas.typ": entradas

#let con-portada = sys.inputs.at("portada", default: "si") != "no"
#let repo = "https://github.com/lfreyes97/leipziger-disputation-1519/issues"

#let edicion(titulo, subtitulo, lang: "la", nota: none, cuerpo) = {
  let version = "Edición de trabajo, " + datetime.today().display("[day]-[month]-[year]")
  let portada = if con-portada { import "portada.typ": portada; portada }
  let legales = if con-portada {
    import "legales.typ": legales
    legales(version: version, url: repo, nota: nota)
  }
  show: book.with(
    title: titulo,
    subtitle: subtitulo,
    author: "Seitz 1903",
    date: version,
    paper: "a4",
    font-size: 12pt,
    margin-inside: 3cm,
    margin-outside: 2.5cm,
    margin-y: 2.5cm,
    fonts: (body: ("EB Garamond 12", "Libertinus Serif"), heading: "IM FELL English", title: "IM FELL English"),
    lang: lang,
    // `la` no tiene etiquetas propias en documentclass: en español
    labels: (part: "Parte", chapter: "Capítulo", appendix: "Apéndice", section: "Sección",
             contents: "Contenido", abstract: "Resumen", figures: "Figuras", tables: "Tablas"),
    use-parts: false,
    // portada, reverso en blanco, portadilla monocromática y otro reverso en blanco
    cover: {
      if portada != none { portada; en-blanco() }
      half-title(title: titulo)
      en-blanco()
    },
    back-cover: none,
  )
  show: titulos
  show: cabeceras.with(titulo)
  set smartquote(enabled: false)
  set par(justify: true)
  // Etiqueta del impreso en la llamada y en el pie (no un número correlativo)
  show footnote.entry: it => {
    set text(size: 0.85em)
    set par(first-line-indent: 0em, hanging-indent: 1.4em)
    numbering(it.note.numbering, ..counter(footnote).at(it.note.location()))
    h(0.4em)
    it.note.body
  }
  legales            // en el reverso de la portada; antes de `front`, que abre en página impar
  show: front
  // contenido hecho a mano y provisional (ver contenido.typ y contenido-entradas.typ)
  heading(outlined: false)[Contenido]
  contenido(entradas)
  v(1.5em)
  text(size: 0.85em, style: "italic")[Las divisiones por materias son provisionales: proceden de un resumen elaborado con IA y no figuran como encabezados en el texto.]
  // sin portada ni legales (--input portada=no) la nota va suelta
  if not con-portada and nota != none { nota }
  // estudio preliminar: traducción del estudio introductorio de Seitz (pp. 1-11)
  [= Estudio preliminar de Otto Seitz (1903) <cap-estudio>]
  [#emph[Traducción al español del estudio introductorio de Seitz (pp. 1--11). Elaborada con IA, sin revisión humana sistemática.]]
  include "../fragmentos/intro.typ"
  show: main
  [#heading(numbering: none)[El debate de Lutero con Eck (4--14 de julio de 1519)] <cap-texto>]
  cuerpo
  [#metadata(none) <fin-texto>]
  // índices (typst compile --input indice=si …): por ahora, personas
  if sys.inputs.at("indice", default: "no") == "si" {
    show: back
    [#heading(numbering: none)[Índice de personas] <cap-indice>]
    [#emph[Prototipo sin curar: marca automáticamente las formas de nombres de una tabla (`edicion/indice-entradas.json`); las cifras son páginas del impreso de Seitz.]]
    indice("personas")
  }
  // apéndice opcional (typst compile --input resumen=si …)
  if sys.inputs.at("resumen", default: "no") == "si" {
    [= Resumen de IA <cap-resumen>]
    [#emph[Resumen elaborado con IA a partir de esta edición. No procede de Seitz y no ha sido verificado ni revisado por una persona.]]
    include "../fragmentos/resumen.typ"
  }
}
