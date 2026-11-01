# Piloto de 10 páginas (impresas 55–64)

Antes de producir el resto se hizo una prueba con el inicio del debate
Lutero–Eck (Seitz 1903, impresas 55–64; PDF 63–72). Servía para fijar el
método y comprobar que funcionaba de principio a fin.

## Qué se probó

- **Convenciones de transcripción** (`docs/CONVENCIONES.md`). El ejemplo de
  referencia es `transcripcion/test/test-p03.md`.
- **Aparato de notas** con claves únicas. En el piloto las claves de nota
  chocaban entre fragmentos (`[^12]` en varios), lo que dio lugar a las
  decisiones 5 y 6 de `docs/RESOLUCIONES.md`: sufijos donde la numeración del
  original colisiona y prefijos `t01`–`t05` por fragmento.
- **Empalmes entre páginas**: un fragmento cruza el salto de la 61 a la 62 a
  mitad de frase. De ahí salió la unión de guiones de fin de página que hace
  `scripts/ensamblar.py`.
- **Traducción** con el mismo aparato y segmentación (`traduccion/test/trad-t0*.md`).
- **Composición**: una plantilla maestra para el piloto en XeLaTeX y otra en
  Typst (A4, Libertinus Serif, latín justificado, notas al pie).

## Dónde está el material

Las pp. 55–64 ya no se ensamblan desde los fragmentos del piloto: se
partieron en una página por archivo, igual que el resto
(`transcripcion/pp-055.md` … `pp-064.md`, `traduccion/trad-pp-055.md` … `trad-pp-064.md`).
Los fragmentos originales se conservan como evidencia en `transcripcion/test/`
y `traduccion/test/`:

| Fragmento | Páginas impresas |
|---|---|
| `test-p01.md` | 55–56 |
| `test-p01b.md` | 56 |
| `test-p02.md` | 56–58 (empieza en la palabra partida «omni-/bus») |
| `test-p03.md` | 59–60 |
| `test-p04.md` | 61–62 |
| `test-p05.md` | 63–64 |

El reparto exacto de páginas por fragmento sale de la alineación con el OCR
(ver `docs/RESOLUCIONES.md`, punto 5, y `docs/REVISION-pp55-64.md`).

Se quitaron del árbol de trabajo, pero siguen en el historial de git
(commit `226591f`, ramas `main` y `latex`):

- `prueba/`: recorte de 10 páginas del facsímil (`luther-eck-test-10pp.pdf`),
  las plantillas maestras `.tex` y `.typ` y sus PDF.
- `output-test/`: los seis fragmentos del piloto convertidos a `.tex` y `.typ`.

Para recuperarlos: `git show 226591f:prueba/plantilla-maestra.typ` o
`git checkout 226591f -- prueba output-test`.
