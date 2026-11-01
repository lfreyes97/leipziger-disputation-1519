// Portada «Lutero contra Eck» — v8, roseta de molinetes (página 1 de la v8).
// Copia de ~/Proyectos/Lutero/portada-lutero-eck-v8.typ, convertida en una
// página reutilizable. Requiere @local/instatypst y las fuentes IM FELL.

#import "@local/instatypst:0.1.0": fleurones as fl
#import "logo-presuposicionalismo.typ": logo


#let tinta = rgb("#1e1610")
#let rojo = rgb("#9a1f17")
#let sc(body) = text(font: "IM FELL English SC", body)

#let W = 21cm
#let H = 29.7cm

#let portada-con(centro) = page(paper: "a4", margin: 0pt, fill: rgb("#efe4c8"), {
  set text(font: "IM FELL English", lang: "es", fill: rgb("#1e1610"), number-type: "lining")
  set par(leading: 0.45em)
  // Orlas: damasco afuera, eslabones adentro, filete doble
  let m = 1cm
  place(top + left, dx: m, dy: m, fl.orla("damasco", W - 2 * m, H - 2 * m, tinta, grosor: 24pt))
  let i = m + 24pt + 4pt
  place(top + left, dx: i, dy: i, fl.orla("eslabones", W - 2 * i, H - 2 * i, rojo, grosor: 12pt))
  i = i + 12pt + 4pt
  place(top + left, dx: i, dy: i, fl.filetes(W - 2 * i, H - 2 * i, tinta, tinta))

  place(top + left, dx: i, dy: i, block(width: W - 2 * i, height: H - 2 * i, inset: (x: 1cm, y: 0.6cm), align(center)[
    #logo(width: 5.5cm, color: rojo)
    #v(0.3cm)

    #text(size: 46pt, fill: rojo)[LVTERO]
    #v(-0.9cm)
    #text(size: 22pt, style: "italic")[contra]
    #v(-0.75cm)
    #text(size: 46pt, fill: rojo)[ECK]

    #v(0.3cm)
    #fl.divisor(7cm, 14pt, rojo, tinta)
    #v(0.4cm)

    #text(size: 13pt)[#sc[O sea, de lo que se disputó en Leipzig]] \
    #text(size: 13pt, style: "italic")[entre el reverendo padre] \
    #v(0.1cm)
    #text(size: 19pt, fill: rojo)[D. MARTÍN LUTERO,] \
    #text(size: 12pt, style: "italic")[agustino, doctor en Teología en Wittenberg,] \
    #v(0.1cm)
    #text(size: 13pt, style: "italic")[y el] \
    #v(0.1cm)
    #text(size: 19pt, fill: rojo)[D. JUAN ECK,] \
    #text(size: 12pt, style: "italic")[doctor y vicecanciller en Ingolstadt,] \
    #v(0.3cm)
    #text(size: 12pt)[acerca del primado del Papa, \ de la autoridad de los Concilios \ y de la Sagrada Escritura.]

    #v(0.4cm, weak: false)
    #v(1fr)
    #centro
    #v(0.4cm, weak: false)
    #v(1fr)

    #text(size: 15pt)[#sc[En Leipzig,]] \
    #text(size: 12pt, style: "italic")[en el Año del Señor] \
    #v(0.1cm)
    #text(size: 17pt, fill: rojo, tracking: 0.08em)[M. D. XIX.]
  ]))
})

#let portada = portada-con(fl.roseta(1.4cm, rojo, tipo: "molinete"))
