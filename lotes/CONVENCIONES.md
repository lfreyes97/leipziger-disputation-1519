# CONVENCIONES — Lotes Luther-Eck (Seitz 1903, solo Markdown)

Fuente: `derauthentischet00eckj.pdf`. Debate II (Lutero-Eck): impresas 55–218 = PDF 63–226 (PDF = impresa + 8).
Ejemplo oro: `output-test/test-p03.md`. Reglas madre: `system-prompt.md` (sin marginalia; aquí solo aplica lo latino).

## Archivo por página impresa
- `lotes/pp-PPP.md` (PPP = 3 dígitos, ej. `pp-065.md`). Sin frontmatter: empieza directo con el cuerpo.
- Al final del archivo, las definiciones de sus notas. Respuesta final del agente: SOLO lista de archivos + nº de notas por página + dudas. NUNCA pegar el texto en el chat.

## Claves de nota (únicas por página)
- `[^PPP-N]` donde N = etiqueta EXACTA del original (`14`, `2a`, `13b`, `34`). Ej: `[^065-14]`.
- Misma etiqueta repetida en la página con la MISMA definición: una sola clave.
- Misma etiqueta con DISTINTA definición (la numeración se reinicia entre discursos): `[^PPP-N]`, `[^PPP-N-2]`, `[^PPP-N-3]`.
- Referencias entre corchetes (`[259]`, `[261]`, `[W. A. 254]`, `[v. 19]`): literales, NO son notas.

## Cuerpo
- Ignorar cabecera de página (`— 65 —`), manchas y ruido. Sin títulos inventados.
- Párrafos en líneas continuas (soft-wrap). Unir palabras partidas a fin de línea (quitar guion).
- Si la página termina a mitad de palabra con guion (`omni-`): conservar el guion final y añadir `<!-- empalme: sigue pp-PPP -->`. El ensamblaje une.
- Si termina a mitad de frase sin guion: terminar normal; el ensamblaje une con salto de párrafo.
- Llamadas superíndices (`existimant³⁴)`) → `existimant[^065-34]`. Sin paréntesis suelto.
- Ilegible: `[...]`. Duplicar erratas de imprenta tal cual (`essee`, `Augustus` por Augustinus): avisar en dudas, no corregir en silencio.

## Aparato crítico (notas al pie de la página impresa)
- Transcribir TODAS, con siglas (`M U Uv Mc Lö P R. a. R.`) y glosas alemanas literales (ä ö ü ß).
- Griego en Unicode directo (`ἀρχήν`). Marcas editoriales literales (`[rot]`, `[gestrichen]`, `(so!)`, `statt`, `Lücke`).

## Verificación
- La primera imagen del lote debe llevar cabecera `— AAA —` (= primera impresa asignada). Si no coincide: DETENERSE e informar (deriva de paginación).
- Render: `pdftoppm -f P -l P -png -r 175 derauthentischet00eckj.pdf /tmp/opencode/leipzig/wX` (P = impresa + 8, wX = prefijo propio).
