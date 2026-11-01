# RESOLUCIONES — Anomalías del impreso y decisiones editoriales

Criterio general: diplomática. La errata se conserva y documenta; jamás se enmienda en silencio.

1. **p.196, llamada `26)` sin definición** (`intelligentiam²⁶)`; el aparato trae 16 sin llamada).
   Decisión: marcador conservado + definición editorial entre paréntesis que declara la errata de numeración. `pp-196.md`.
2. **p.205, llamadas `21a/21b` con definiciones numeradas `24a/24b`** (verificado a 400 dpi).
   Decisión: claves renombradas a la llamada (`[^205-21a/b]`) con la errata declarada en la propia definición.
3. **Nota 32 partida entre pp.92–93** (definición empieza en 92 y sigue en 93).
   Decisión: texto fusionado en `[^092-32]`; comentario residual en p.93.
4. **Definiciones sin llamada visible** (`061-14`, `103-18`, `124-15b`, `128-15`, `196-16`, `212-27`).
   Decisión: conservadas; en el ensamblado van a un párrafo final de notas sin llamada.
   (`061-14`: la nota 14 de la p. 61 figura en el impreso, pero su llamada no figura en el texto transcrito.)
5. **Piloto (pp. 55–64): partido en páginas.** Las pp. 55–64 se transcribieron y tradujeron en seis
   fragmentos (`transcripcion/test/`, `traduccion/test/`) con claves provisionales (`t01-12`, `21b2`, `-62`, `-64`…).
   Decisión: partidos en `pp-055.md` … `pp-064.md` y `trad-pp-055.md` … `trad-pp-064.md`, con las claves y las
   etiquetas del impreso. La etiqueta repetida en una misma página se resuelve con `-2` (`056-14-2`, `060-12-2`).
   Los cortes de página del latín salen de la alineación con el OCR; los del español, de los llamados de nota y
   del latín (ver `docs/REVISION-pp55-64.md`). Sustituye a las decisiones anteriores sobre `21b2` y sobre
   el prefijado `t01-…t05-`.
