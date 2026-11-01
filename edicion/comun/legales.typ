// Página de legales — «Lutero contra Eck»
// Basada en ~/Proyectos/Lutero/legales.typ, con el aviso sobre el uso de IA.
// Requiere @local/instatypst y las fuentes IM FELL.

#import "@local/instatypst:0.1.0": fleurones as fl

#let rojo = rgb("#9a1f17")
#let sc(body) = text(font: "IM FELL English SC", body)

#let legales(version: "", url: "", nota: none) = page(paper: "a4", margin: (x: 3cm, y: 3cm), numbering: none, fill: rgb("#efe4c8"), {
  set text(font: "IM FELL English", lang: "es", size: 9pt, fill: rgb("#1e1610"), number-type: "lining")
  set par(leading: 0.6em, spacing: 1.1em, justify: false)
  v(1fr)
  block(width: 10cm)[
    #fl.vineta("cruz", 10pt, rojo)

    #sc[Fuente.] Otto Seitz, #emph[Der authentische Text der Leipziger
    Disputation (1519)], Berlín, 1903, pp. 55--218.

    #sc[Elaboración con IA.] La transcripción del original latino y su
    traducción al español las produjo un modelo de inteligencia artificial.
    No han tenido revisión humana sistemática y pueden contener errores.
    Antes de citar un pasaje, compruébese en el facsímil de Seitz. #if url != "" [
      Las erratas se reportan en #text(size: 8pt)[#url].]

    #sc[Dominio público.] El texto latino del debate de Lutero con Eck (Disputa
    de Leipzig, 1519) es de dominio público. La transcripción y la traducción se dedican asimismo
    al dominio público mediante #emph[Creative Commons CC0 1.0 Universal]:
    pueden copiarse, modificarse, distribuirse y publicarse, incluso con
    fines comerciales, sin pedir permiso. \
    #text(size: 8pt)[https:\/\/creativecommons.org/publicdomain/zero/1.0/deed.es]

    #sc[Tipografía.] Compuesto en IM FELL English e IM FELL English SC;
    orlas y viñetas en IM FELL FLOWERS~1 y~2. \
    #text(style: "italic", fl.credito)

    #if nota != none [#sc[Criterios.] #nota]

    #if version != "" [#sc[Edición.] #version]
  ]
})
