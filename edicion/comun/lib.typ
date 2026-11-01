// Composición común de las cuatro ediciones (crítica y lectura, latina y española).
// Requiere @local/documentclass y @local/instatypst (portada y legales).
// Sin portada ni legales: typst compile --input portada=no …
#import "@local/documentclass:0.1.0": book, front, main
#import "aparato.typ": apnota

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
    font-size: 11pt,
    margin-inside: 3cm,
    margin-outside: 2.5cm,
    margin-y: 2.5cm,
    fonts: (body: "Libertinus Serif", heading: "IM FELL English", title: "IM FELL English"),
    lang: lang,
    use-parts: false,
    cover: portada,
    back-cover: none,
  )
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
  show: front
  legales
  // sin portada ni legales (--input portada=no) la nota va suelta
  if not con-portada and nota != none { nota }
  // paratextos: estudio preliminar e introducción de Seitz (traducida)
  [= Estudio preliminar]
  include "../fragmentos/estudio.typ"
  [= Introducción de Otto Seitz (1903)]
  [#emph[Traducción al español de la introducción de Seitz (pp. 1--11). Elaborada con IA, sin revisión humana sistemática.]]
  include "../fragmentos/intro.typ"
  show: main
  cuerpo
}
