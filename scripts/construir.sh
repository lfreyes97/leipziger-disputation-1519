#!/bin/sh
# Regenera los fragmentos Typst desde los lotes Markdown y compila las cuatro
# ediciones en build/. Requiere typst, @local/documentclass y @local/instatypst.
# Fuentes IM FELL: FONTS=<carpeta> (por defecto ~/Projects/Instatypst/Fonts).
set -e
cd "$(dirname "$0")/../edicion"
FONTS="${FONTS:-$HOME/Projects/Instatypst/Fonts}"
mkdir -p ../build

for n in 1 2 3; do
  lote=$(ls lote$n-pp*.md); trad=$(ls trad$n-pp*.md); rng=${lote#lote$n-}
  python3 ../scripts/md2typ.py "$lote" > lote$n.typ
  python3 ../scripts/md2typ.py "$trad" > trad$n.typ
  python3 ../scripts/md2lectura.py "$lote" --typ lec$n.typ --md lec$n-$rng
  python3 ../scripts/md2lectura.py "$trad" --typ lectrad$n.typ --md lectrad$n-$rng
done

for e in edicion-latina edicion-espanola lectura-latina lectura-espanola; do
  typst compile --ignore-system-fonts --font-path "$FONTS" $e.typ ../build/$e.pdf
done
