# PLAN EDITORIAL — Disputa Lutero-Eck (Seitz 1903)

## 1. Colación y corrección
- Cruce automático transcripción ↔ OCR ABBYY (`derauthentischet00eckj_djvu.xml`, palabra por página) → ranking de páginas sospechosas.
- Segunda pasada humana (subagentes) solo sobre páginas divergentes + erratas ya listadas en reportes.
- Criterio: diplomática (se conserva la errata con `(so!)` o aviso; no se enmienda en silencio).

## 2. Aparato y anomalías → `docs/RESOLUCIONES.md`
- 6 anomalías documentadas con decisión aplicada (196-26, 205-21a/b, nota 32 en 92–93, defs sin llamada 103-18/124-15b/128-15/212-27, 21b duplicado 59/60).
- Normalizar claves y trafegar glosas alemanas sin traducir.

## 3. Índices y paratextos
- Índice de nombres, citas bíblicas (`[v. X]`, Salmos, Mt/Jn...), referencias `[NNN]`/W.A., sesiones por día (4–14 julio).
- Portada, colofón metodológico, tabla de sesiones.

## 4. Estudio preliminar
- Base: intro de Seitz (impresas 1–11, por transcribir) + contexto 1519 (Karlstadt/Eck previo, legación, actas notariales).
- Guía de lectura del argumento (primado, concilios, Escritura).

## 5. Maquetación v2
- Clase article twoside, cabezas de página, portada, colofón, notas con etiqueta original (`\apnota`), Libertinus + XeLaTeX.
- Volúmenes: latino y español en paralelo, misma segmentación.
