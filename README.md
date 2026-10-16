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
| `fuentes/seitz1903/` | Facsímil y OCR de Seitz 1903 (Internet Archive, `derauthentischet00eckj`) |
| `fuentes/hase1827/` | Facsímil y OCR de Hase 1827 (Múnich BSB; sin transcribir aún) |
| `transcripcion/` | Latín página por página: `pp-065…218.md`, `intro-pp-001…011.md`, piloto `test-p0*.md` |
| `traduccion/` | Español: `trad-pp-*.md`, `trad-t0*.md` (mismo aparato y segmentación) |
| `edicion/` | Lotes ensamblados (`lote*`, `trad*`, `lec*`), TeX y PDFs crítica/lectura |
| `prueba/` | Piloto de 10 pp.: recorte PDF + maestras XeLaTeX/Typst |
| `scripts/` | `ensamblar.py`, `md2tex.py`, `md2lectura.py`, `colacion.py`, `indices.py` |
| `docs/` | Método: convenciones, prompts, plan, resoluciones, colación, estudio, índices |

## Cómo se hizo (transparencia)

1. Transcripción íntegramente con IA (OpenCode Desktop, modelo Muse,
   variante xhigh): agentes paralelos por tramos de ~10 pp., desde
   renderizados del PDF a 175–200 dpi, con convenciones fijas y ejemplo oro.
   Mapeo verificado: PDF = impresa + 8.
2. Integridad verificada por script (`scripts/ensamblar.py --check`): cada
   llamada `[^PPP-N]` tiene su definición; ensamblaje determinista con
   unión de guiones de fin de página.
3. Colación automática contra el OCR ABBYY (`scripts/colacion.py` → informe):
   mediana de divergencia A=4/B=11 por página (ruido de fondo).
4. Segunda pasada también con IA (agentes revisores contra el impreso) en
   las 20 páginas más divergentes → 3 correcciones aplicadas (`anxiis`,
   `consessu`, `probavimus`), más una línea omitida en p.154 detectada al
   revisar un empalme. El resto, basura OCR confirmada.
5. Traducción con IA desde la transcripción (no desde imagen), aparato
   copiado literal; cotejo latín↔español por script: 10 llamadas repuestas.
6. Derivados TeX 100 % deterministas (`md2tex.py`, `md2lectura.py`); nunca
   se edita un `.tex` a mano: la fuente canónica es el Markdown.

Límites conocidos: no ha habido revisión humana sistemática; el responsable
ha leído páginas sueltas sin colación completa. La traducción tiene
revisión de claves completa pero revisión filológica solo por muestreo; los
índices están sin curar.

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
