# Disputa de Leipzig (1519) — Lutero contra Eck

Transcripción latina, traducción al español y ediciones de la Disputa de
Leipzig (4–14 de julio de 1519) a partir de Otto Seitz, *Der authentische
Text der Leipziger Disputation* (Berlín, 1903), pp. 55–218.

> **Aviso: este texto lo hizo una IA y no ha tenido revisión humana
> sistemática.**
> La transcripción del latín y la traducción al español las produjo un
> modelo de IA. Tienen verificaciones automáticas (ver más abajo), pero nadie
> las ha cotejado de principio a fin contra el facsímil. Hay errores que aún
> no se han encontrado. No cites este texto como edición crítica sin
> comprobar el pasaje en Seitz. Si encuentras un error, abre un *issue*.

## Estado

| Parte | Estado |
|---|---|
| Transcripción latina, pp. 55–218 (164 páginas impresas) | Hecha con IA; sin revisión humana sistemática |
| Traducción al español, pp. 55–218 | Hecha con IA desde la transcripción; revisión filológica solo por muestreo |
| Aparato de notas | 2788 notas en las pp. 65–218; verificadas por script (ninguna llamada sin definición ni clave duplicada) |
| Introducción de Seitz (impresas 1–11) | Transcrita; sin traducir |
| Estudio preliminar (`docs/ESTUDIO-PRELIMINAR.md`) | **Borrador de IA** con pasajes marcados «no verificado»; no es texto definitivo |
| Índices (`docs/INDICES-borrador.md`) | Borrador automático, sin curar |
| Ediciones en PDF | En preparación (esta rama pasa la composición a Typst) |
| Hase 1827 (`fuentes/hase1827/`) | Solo el facsímil; sin transcribir |

## Ramas

- **`typst`** (rama por defecto): composición con Typst.
- **`latex`**: composición con XeLaTeX, conservada como alternativa.

Las dos comparten las mismas fuentes en Markdown (`transcripcion/`,
`traduccion/`) y se diferencian solo en los archivos de composición.

## Qué hay en el repositorio

| Ruta | Contenido |
|---|---|
| `transcripcion/` | Latín, una página impresa por archivo (`pp-065.md` … `pp-218.md`), la introducción de Seitz (`intro-pp-*.md`) y el piloto (`test-p0*.md`) |
| `traduccion/` | Español, con la misma segmentación y el mismo aparato (`trad-pp-*.md`) |
| `edicion/` | Lotes ensamblados desde las páginas (`lote*`, `trad*`, `lec*`, `lectrad*`) |
| `fuentes/seitz1903/` | Facsímil y OCR de Seitz 1903 (Internet Archive, `derauthentischet00eckj`) |
| `fuentes/hase1827/` | Facsímil y OCR de Hase 1827 (Biblioteca Estatal de Baviera) |
| `scripts/` | Ensamblado, colación contra OCR, índices y conversores |
| `docs/` | Método: convenciones, prompts, plan editorial, resoluciones de anomalías, informe de colación y descripción del piloto (`PILOTO.md`) |

Para citar un pasaje, usa la página impresa de Seitz. El PDF del facsímil
tiene 8 páginas más (PDF = impresa + 8).

## Cómo se hizo

1. **Transcripción con IA** (OpenCode Desktop, modelo Muse, variante xhigh):
   agentes en paralelo por tramos de unas 10 páginas, a partir de imágenes del
   PDF a 175–200 dpi y con convenciones fijas (`docs/CONVENCIONES.md`).
2. **Integridad por script** (`scripts/ensamblar.py --check`): cada llamada de
   nota `[^PPP-N]` tiene su definición, y el ensamblado de las páginas es
   determinista, con unión de guiones de fin de página.
3. **Colación automática contra el OCR** (`scripts/colacion.py`, informe en
   `docs/colacion-reporte.md`). Por página, la mediana es de 4 palabras que
   el OCR tiene y la transcripción no (posibles omisiones) y de 11 que tiene
   la transcripción y el OCR no (posibles añadidos o fallos del OCR). Es
   ruido de fondo esperado.
4. **Segunda pasada, también con IA**, sobre las 20 páginas más divergentes.
   Corrigió 3 errores (`anxiis`, `consessu`, `probavimus`) y una línea omitida
   en la p. 154, hallada al revisar un empalme. El resto de divergencias
   eran errores del OCR.
5. **Traducción con IA** desde la transcripción, no desde la imagen, con el
   aparato copiado literalmente. Un cotejo por script repuso 10 llamadas de
   nota.
6. **Derivados deterministas.** Los archivos de composición se generan desde
   el Markdown y no se editan a mano. La fuente canónica es el Markdown.

### Límites conocidos

- No hay revisión humana sistemática. El responsable de la edición ha leído
  páginas sueltas, sin colación completa.
- La colación compara contra un OCR, no contra la imagen. Un error que el OCR
  repite de la misma manera pasa desapercibido.
- La traducción no tiene un glosario fijo de términos técnicos, así que puede
  haber traducciones inconsistentes entre pasajes.
- La transcripción es diplomática: la errata del original se conserva con
  `(so!)` o un aviso, y no se corrige en silencio.

## Cómo reportar un error

Abre un *issue* indicando:

1. La **página impresa** de Seitz (no la del PDF).
2. La **línea** o la palabra afectada.
3. Lo que dice **este repositorio** y lo que dice **el facsímil**.
4. Si es un error de transcripción (latín) o de traducción (español).

Cada corrección aceptada se registra en `docs/`.

## Compilar

La composición en Typst está en preparación y todavía no hay un comando de
compilación estable. La rama `latex` tiene el flujo anterior con XeLaTeX, con
sus instrucciones.

Los scripts de `scripts/` requieren Python 3 y no usan red ni APIs.

## Licencia

- **Facsímiles y OCR de las fuentes:** dominio público (Seitz 1903, Hase 1827).
  Los archivos originales proceden de Internet Archive y de la Biblioteca
  Estatal de Baviera; consulta sus condiciones de uso.
- **Transcripciones, traducciones, scripts y ediciones de este repositorio:**
  CC0 1.0 (ver `LICENSE`). Puedes usarlos, copiarlos y modificarlos sin
  permiso ni atribución.
