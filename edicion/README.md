# edicion/

| Ruta | Contenido |
|---|---|
| `edicion-latina.typ`, `edicion-espanola.typ` | Ediciones críticas (con aparato) |
| `lectura-latina.typ`, `lectura-espanola.typ` | Ediciones de lectura (sin aparato) |
| `comun/` | `lib.typ` (clase y maqueta), `aparato.typ` (notas y referencias), `portada.typ`, `legales.typ`, `logo-presuposicionalismo.typ` |
| `lotes/` | Markdown ensamblado desde `transcripcion/` y `traduccion/` (`ensamblar.py`) y versiones de lectura (`md2lectura.py`) |
| `fragmentos/` | Typst generado desde `lotes/` (`md2typ.py`, `md2lectura.py`) |

`lotes/` y `fragmentos/` son derivados: no se editan a mano. Se regeneran con
`scripts/construir.sh`, que también compila los PDF en `build/`.
