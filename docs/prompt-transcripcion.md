# Prompt — Transcripción por fragmentos (Leipziger Disputation 1519)

> Uso: copiar y rellenar variables por fragmento. Salida: **solo cuerpo Markdown concatenable**. Sin preámbulo ni cierre.

## Variables

- `{{START_PAGE}}-{{END_PAGE}}`: páginas del original en este bloque.
- `{{FUENTE}}`: ej. `Seitz 1903 (latín) pp. X-Y` o `Hase 1827 (Fraktur) pp. X-Y`.
- `{{CONTEXTO_COLA}}`: últimos ~800 caracteres del bloque anterior, cortados en frontera de palabra.
- `{{TERMINA_EN_GUION}}`: `true/false`.
- `{{MARGINALIA}}`: `INCLUIR` / `IGNORAR`.

## Prompt reutilizable

```text
Actúa como paleógrafo digital experto. Transcripción diplomática fiel, sin modernizar ni traducir.

Fragmento: páginas {{START_PAGE}}-{{END_PAGE}} del original.
FUENTE: {{FUENTE}}
IDIOMA PRINCIPAL: LATÍN o ALEMÁN (Fraktur). Secundarios: el otro. No traduzcas.
FORMATO SALIDA: MARKDOWN. SOLO cuerpo/fragmento.

CONTEXTO PREVIO (solo continuidad, NO re-transcribas):
<contexto>...{{CONTEXTO_COLA}}</contexto>
TERMINA_EN_GUION: {{TERMINA_EN_GUION}}

PROTOCOLO DE EMPALME:
- Si TERMINA_EN_GUION=true, la primera palabra completa la anterior. Únela sin guion ni espacio (cons- + titución -> constitución).
- Si false, empieza con palabra completa nueva. No repitas contexto.

REGLAS:
1. SOLO Markdown del cuerpo. PROHIBIDO: YAML frontmatter (---), <html>, <body>, fences ```, títulos inventados.
2. FLUJO CONTINUO: ignora saltos físicos de página/columna. No uses --- ni saltos forzados.
3. NO transcribas running heads, folios, signaturas ni paginación impresa.
4. Ortografía original: conserva u/v, i/j, puntuación, mayúsculas. No normalices. Abreviaturas sin expandir; si expands, marca: *[expandido]* + nota.
5. Formato interno permitido: *cursiva*, **negrita**, notas `[^1]` al pie del punto semántico.
6. MARGINALIA={{MARGINALIA}}: si INCLUIR, inserta como `[^n]: marg.: ...`. Si IGNORAR, omítelas.
7. Ilegible: `[...]` o `[???]`. Nunca inventes ni resumas.
8. Fraktur (Hase 1827): ſ -> s, conserva ä ö ü ß. Latín (Seitz 1903): conserva ligaduras æ œ solo si legibles.

Salida: puramente Markdown concatenable, sin explicación externa.
```

## Ejemplo rellenado (Seitz)

```text
Fragmento: páginas 12-15 del original.
FUENTE: Seitz 1903, Der authentische Text der Leipziger Disputation, Erste Disputation Karlstadt-Eck (texto latino, intro alemana)
...
MARGINALIA=IGNORAR
```

## Ejemplo rellenado (Hase)

```text
Fragmento: páginas 1-5 del original.
FUENTE: Hase 1827, Die Leipziger Disputation: eine theologische Denkschrift (Fraktur alemana)
...
MARGINALIA=INCLUIR
```
