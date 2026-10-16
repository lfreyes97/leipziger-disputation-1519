# Disputa de Leipzig (1519) — Lutero contra Eck

Transcripción diplomática, traducción al español y ediciones en LaTeX del
debate Lutero–Eck (4–14 de julio de 1519), a partir de la edición de
Otto Seitz, *Der authentische Text der Leipziger Disputation* (Berlín, 1903).

## Estado

Edición de trabajo: 164 páginas impresas (55–218), ~3000 notas de aparato,
verificación automática de integridad al 100 % (cero llamadas sin definición,
cero claves duplicadas) + colación contra OCR y segunda pasada humana en las
20 páginas más divergentes (3 errores reales corregidos).

## Contenido

| Ruta | Qué es |
|---|---|
| `derauthentischet00eckj.pdf` (+ `.xml`, `_djvu.txt`, `_hocr.html`, `_meta.xml`, `_scandata.xml`, `_marc.xml`) | Facsímil y OCR de Seitz 1903 (Internet Archive, `derauthentischet00eckj`) |
| `hase1827_10773137bsb.*` | Facsímil y OCR de Hase 1827 (Múnich BSB, Freiburg; sin transcribir aún) |
| `lotes/pp-*.md` (154) + `output-test/test-p0*.md` | Transcripción latina página por página (impresas 55–218) |
| `lotes/trad-pp-*.md` (154) + `lotes/trad-t0*.md` | Traducción española, mismo aparato y segmentación |
| `lotes/lote{1,2,3}-pp*.md`, `lotes/trad{1,2,3}-pp*.md` | Lotes ensamblados latín/español |
| `lotes/lec*.md`, `lotes/lectrad*.md` | Versiones de lectura (sin aparato) |
| `lotes/edicion-latina.pdf`, `edicion-espanola.pdf` | Edición crítica (XeLaTeX, etiquetas originales) |
| `lotes/lectura-latina.pdf`, `lectura-espanola.pdf` | Edición de lectura (oradores como encabezados) |
| `lotes/intro-pp-*.md` | Introducción de Seitz (impresas 1–11) |
| `lotes/ESTUDIO-PRELIMINAR.md`, `INDICES-borrador.md` | Paratextos (borrador) |

Método y convenciones: `system-prompt.md`, `prompt-transcripcion.md`,
`lotes/CONVENCIONES.md`, `lotes/TRADUCCION.md`, `lotes/PLAN-EDITORIAL.md`,
`lotes/RESOLUCIONES.md` (6 anomalías del impreso, documentadas).

## Cómo se hizo (transparencia)

1. Transcripción asistida por IA (agentes paralelos por tramos de ~10 pp.,
   desde renderizados del PDF a 175–200 dpi), con convenciones fijas y
   ejemplo oro. Mapeo verificado: PDF = impresa + 8.
2. Integridad verificada por script (`lotes/ensamblar.py --check`): cada
   llamada `[^PPP-N]` tiene su definición; ensamblaje determinista con
   unión de guiones de fin de página.
3. Colación automática contra el OCR ABBYY (`lotes/colacion.py` → informe):
   mediana de divergencia A=4/B=11 por página (ruido de fondo).
4. Segunda pasada humana contra el impreso en las 20 páginas más
   divergentes → 3 errores reales corregidos (`anxiis`, `consessu`,
   `probavimus`). El resto, basura OCR confirmada.
5. Traducción asistida por IA desde la transcripción (no desde imagen),
   aparato copiado literal; cotejo latín↔español: 10 llamadas repuestas.
6. Derivados TeX 100 % deterministas (`md2tex.py`, `md2lectura.py`); nunca
   se edita un `.tex` a mano: la fuente canónica es el Markdown.

Límites conocidos: la segunda pasada humana cubrió 20/164 páginas; la
traducción tiene revisión de claves completa pero revisión filológica solo
por muestreo; los índices están sin curar.

## Compilar

```sh
cd lotes
python3 ensamblar.py lote1 55 109   # + lote2/lote3, trad1/2/3
python3 md2tex.py lote1-pp055-109.md > lote1.tex  # + resto
xelatex edicion-latina.tex   # x2; idem edicion-espanola, lectura-*
```

Requiere: `poppler-utils` (pdftoppm), TeX Live con `xelatex`, fuente
Libertinus Serif. Sin dependencias de red ni APIs.

## Licencia

- Facsímiles y OCR fuente: dominio público (Seitz 1903; Hase 1827).
- Transcripciones, traducciones, scripts y ediciones de este repo: CC0 1.0
  (ver `LICENSE`). Úsese, cópiese y mejórese libremente.
