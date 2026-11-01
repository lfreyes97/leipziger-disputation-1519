#!/bin/sh
# Regenera los fragmentos Typst desde los lotes Markdown y compila las cuatro
# ediciones en build/. Requiere typst, @local/documentclass y @local/instatypst.
# Fuentes IM FELL: FONTS=<carpeta> (por defecto ~/Projects/Instatypst/Fonts).
set -e
cd "$(dirname "$0")/../edicion"
FONTS="${FONTS:-$HOME/Projects/Instatypst/Fonts}"
mkdir -p ../build

for n in 1 2 3; do
  lote=$(ls lotes/lote$n-pp*.md); trad=$(ls lotes/trad$n-pp*.md); rng=${lote#lotes/lote$n-}
  python3 ../scripts/md2typ.py "$lote" > fragmentos/lote$n.typ
  python3 ../scripts/md2typ.py "$trad" > fragmentos/trad$n.typ
  python3 ../scripts/md2lectura.py "$lote" --typ fragmentos/lec$n.typ --md lotes/lec$n-$rng
  python3 ../scripts/md2lectura.py "$trad" --typ fragmentos/lectrad$n.typ --md lotes/lectrad$n-$rng
done

for e in edicion-latina edicion-espanola lectura-latina lectura-espanola; do
  typst compile --ignore-system-fonts --font-path "$FONTS" $e.typ ../build/$e.pdf
done
