#!/bin/sh
# Prepara build/release/: las cuatro ediciones con nombre de descarga legible,
# sumas SHA-256 y NOTAS.md. No publica nada (ver docs/PENDIENTE-release.md).
# Uso: scripts/preparar-release.sh v0.1.0
set -e
VERSION="${1:?uso: preparar-release.sh vX.Y.Z}"
cd "$(dirname "$0")/.."
URL="https://github.com/lfreyes97/leipziger-disputation-1519"

scripts/construir.sh >/dev/null            # sin índice ni resumen (opcionales)

R=build/release
rm -rf "$R"; mkdir -p "$R"
n=Lutero-Eck-1519
cp build/edicion-latina.pdf    "$R/${n}_latin_critica.pdf"
cp build/lectura-latina.pdf    "$R/${n}_latin_lectura.pdf"
cp build/edicion-espanola.pdf  "$R/${n}_espanol_critica.pdf"
cp build/lectura-espanola.pdf  "$R/${n}_espanol_lectura.pdf"
(cd "$R" && sha256sum *.pdf > SHA256SUMS.txt)

cat > "$R/NOTAS.md" <<NOTAS
# $VERSION — borrador de IA, sin revisión humana sistemática

Debate de Lutero con Eck (Leipzig, 4–14 de julio de 1519), según Otto Seitz,
*Der authentische Text der Leipziger Disputation* (Berlín, 1903), pp. 55–218.

> **La transcripción del latín, la traducción al español y la traducción del
> estudio de Seitz las hizo una IA. Nadie las ha cotejado de principio a fin con
> el facsímil.** No cites un pasaje sin comprobarlo en Seitz.

## Archivos

| Archivo | Qué es |
|---|---|
| \`${n}_latin_critica.pdf\` | Texto latino con el aparato crítico |
| \`${n}_latin_lectura.pdf\` | Texto latino sin aparato, para lectura seguida |
| \`${n}_espanol_critica.pdf\` | Traducción española con el aparato crítico |
| \`${n}_espanol_lectura.pdf\` | Traducción española sin aparato, para lectura seguida |
| \`SHA256SUMS.txt\` | Sumas de verificación |

Todas llevan, al comienzo, la traducción del estudio preliminar de Seitz y,
en el margen, la paginación de Seitz. El resto de la Disputa de Leipzig (en
particular el debate de Carlstadt con Eck) no está incluido.

## Erratas y licencia

Para reportar un error, abre un *issue* con la plantilla «Errata»:
$URL/issues

Fuentes, transcripción, traducción y scripts: CC0 1.0 (dominio público).
NOTAS
echo "Preparado en $R:"; ls -l "$R"
