// Saltos de página con respiración: los capítulos empiezan en página impar (recto)
// y las páginas que quedan en blanco por ello se reconocen para no ponerles
// cabecera ni pie.
#let _antes = <ed-salto-antes>
#let _despues = <ed-salto-despues>

// Salto a página impar, con marcas a ambos lados: las páginas que quedan
// estrictamente entre las dos marcas son páginas en blanco.
#let salto-impar() = {
  [#metadata(none) <ed-salto-antes>]
  pagebreak(to: "odd", weak: true)
  [#metadata(none) <ed-salto-despues>]
}

// ¿La página `p` quedó en blanco por un salto-impar? (requiere `context`)
#let pagina-en-blanco(p) = {
  query(_antes).zip(query(_despues)).any(((a, d)) =>
    a.location().page() < p and p < d.location().page())
}

// Página en blanco intencional (sin cabecera, pie ni número)
#let en-blanco() = page(numbering: none, header: none, footer: none)[]
