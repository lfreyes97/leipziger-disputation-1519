#!/bin/sh
# Ensambla las páginas en lotes, regenera los fragmentos Typst y compila las cuatro
# ediciones en build/. Requiere typst, @local/documentclass y @local/instatypst.
# Fuentes IM FELL: FONTS=<carpeta> (por defecto ~/Projects/Instatypst/Fonts).
# RESUMEN=si añade al final de cada edición el apéndice «Resumen de IA» (docs/RESUMEN-IA.md).
set -e
cd "$(dirname "$0")/../edicion"
FONTS="${FONTS:-$HOME/Projects/Instatypst/Fonts}"
mkdir -p ../build

# 1. páginas -> lotes
python3 ../scripts/ensamblar.py lote1 55 109;  python3 ../scripts/ensamblar.py trad1 55 109
python3 ../scripts/ensamblar.py lote2 110 164; python3 ../scripts/ensamblar.py trad2 110 164
python3 ../scripts/ensamblar.py lote3 165 218; python3 ../scripts/ensamblar.py trad3 165 218
python3 ../scripts/ensamblar.py tradintro 1 11

# 2. lotes -> fragmentos Typst
python3 ../scripts/md2typ.py lotes/tradintro-pp001-011.md --titulo-inicial > fragmentos/intro.typ
if [ "$RESUMEN" = si ]; then python3 ../scripts/md2prosa.py ../docs/RESUMEN-IA.md > fragmentos/resumen.typ; fi
for n in 1 2 3; do
  lote=$(ls lotes/lote$n-pp*.md); trad=$(ls lotes/trad$n-pp*.md); rng=${lote#lotes/lote$n-}
  python3 ../scripts/md2typ.py "$lote" > fragmentos/lote$n.typ
  python3 ../scripts/md2typ.py "$trad" > fragmentos/trad$n.typ
  python3 ../scripts/md2lectura.py "$lote" --typ fragmentos/lec$n.typ --md lotes/lec$n-$rng
  python3 ../scripts/md2lectura.py "$trad" --typ fragmentos/lectrad$n.typ --md lotes/lectrad$n-$rng
done

# 3. compilar
for e in edicion-latina edicion-espanola lectura-latina lectura-espanola; do
  typst compile --ignore-system-fonts --font-path "$FONTS" --input resumen="${RESUMEN:-no}" $e.typ ../build/$e.pdf
done
