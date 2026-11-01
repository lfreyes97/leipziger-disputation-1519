#!/bin/sh
# Ensambla las páginas en lotes, regenera los fragmentos Typst y compila las cuatro
# ediciones en build/. Requiere typst, @local/documentclass y @local/instatypst.
# Fuentes IM FELL: FONTS=<carpeta> (por defecto ~/Projects/Instatypst/Fonts).
# «construir.sh espanol» compila solo las ediciones en español; «construir.sh resumen»,
# solo el documento suelto «Resumen de IA».
# INDICE=si añade al final el índice de personas (prototipo).
# RESUMEN=si añade al final de cada edición el apéndice «Resumen de IA» (docs/RESUMEN-IA.md).
set -e
cd "$(dirname "$0")/../edicion"
FONTS="${FONTS:-$HOME/Projects/Instatypst/Fonts}"
mkdir -p ../build

# «construir.sh resumen»: solo el documento suelto «Resumen de IA»
if [ "$1" = resumen ]; then
  python3 ../scripts/md2prosa.py ../docs/RESUMEN-IA.md > fragmentos/resumen.typ
  typst compile --ignore-system-fonts --font-path "$FONTS" resumen-ia.typ ../build/resumen-ia.pdf
  exit 0
fi

# 1. páginas -> lotes
python3 ../scripts/ensamblar.py lote1 55 109;  python3 ../scripts/ensamblar.py trad1 55 109
python3 ../scripts/ensamblar.py lote2 110 164; python3 ../scripts/ensamblar.py trad2 110 164
python3 ../scripts/ensamblar.py lote3 165 218; python3 ../scripts/ensamblar.py trad3 165 218
python3 ../scripts/ensamblar.py tradintro 1 11

# 2. lotes -> fragmentos Typst
python3 ../scripts/indice_marcas.py
python3 ../scripts/md2typ.py lotes/tradintro-pp001-011.md --titulo-inicial --cursiva > fragmentos/intro.typ
if [ "$RESUMEN" = si ]; then python3 ../scripts/md2prosa.py ../docs/RESUMEN-IA.md > fragmentos/resumen.typ; fi
for n in 1 2 3; do
  lote=$(ls lotes/lote$n-pp*.md); trad=$(ls lotes/trad$n-pp*.md); rng=${lote#lotes/lote$n-}
  python3 ../scripts/md2typ.py "$lote" --idioma=la > fragmentos/lote$n.typ
  python3 ../scripts/md2typ.py "$trad" --idioma=es > fragmentos/trad$n.typ
  python3 ../scripts/md2lectura.py "$lote" --idioma la --typ fragmentos/lec$n.typ --md lotes/lec$n-$rng
  python3 ../scripts/md2lectura.py "$trad" --idioma es --typ fragmentos/lectrad$n.typ --md lotes/lectrad$n-$rng
done

# 3. compilar
# «construir.sh espanol» compila solo las dos ediciones en español (las que se publican)
EDICIONES="edicion-latina edicion-espanola lectura-latina lectura-espanola"
[ "$1" = espanol ] && EDICIONES="edicion-espanola lectura-espanola"
for e in $EDICIONES; do
  typst compile --ignore-system-fonts --font-path "$FONTS" --input resumen="${RESUMEN:-no}" --input indice="${INDICE:-no}" $e.typ ../build/$e.pdf
done
