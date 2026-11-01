#!/usr/bin/env python3
"""Convierte un Markdown de prosa (estudio preliminar) a fragmento .typ.
Uso: python3 md2prosa.py docs/RESUMEN-IA.md > edicion/fragmentos/resumen.typ
Admite: # título (se omite: lo pone la maqueta), «>» (se omite), ## y ### encabezados, párrafos,
**negrita**, *cursiva*, `código`, listas con «- », tablas con «|» y «---».
"""
import re, sys
from pathlib import Path

ESPECIALES = '\\#$*_@<>[]`~'


def esc(s):
    s = ''.join('\\' + c if c in ESPECIALES else c for c in s)
    return s.replace('//', '\\/\\/').replace('...', '.\\.\\.').replace('--', '-\\-')


def inline(s):
    out = []
    for t in re.split(r'(\*\*.+?\*\*|`[^`]+`|\*[^*\s][^*]*?\*)', s):
        if t.startswith('**') and t.endswith('**') and len(t) > 4:
            out.append('#strong[' + inline(t[2:-2]) + ']')
        elif t.startswith('`') and t.endswith('`') and len(t) > 2:
            out.append('#raw("' + t[1:-1].replace('\\', '\\\\').replace('"', '\\"') + '")')
        elif t.startswith('*') and t.endswith('*') and len(t) > 2:
            out.append('#emph[' + inline(t[1:-1]) + ']')
        else:
            out.append(esc(t))
    return ''.join(out)


def convertir(src):
    out, lines, i = [], src.splitlines(), 0
    while i < len(lines):
        l = lines[i]
        if l.startswith('>'):   # avisos del documento fuente: no van al PDF
            i += 1
            continue
        if not l.strip() or l.startswith('# ') or l.strip() == '---':
            out.append('' if not l.strip() else None)
            i += 1
            continue
        if l.startswith('### '):
            out.append('=== ' + inline(l[4:].strip())); i += 1; continue
        if l.startswith('## '):
            out.append('== ' + inline(l[3:].strip())); i += 1; continue
        if l.startswith('|'):
            filas = []
            while i < len(lines) and lines[i].startswith('|'):
                if not re.match(r'^\|[\s:-]+\|', lines[i]):
                    filas.append([c.strip() for c in lines[i].strip().strip('|').split('|')])
                i += 1
            n = len(filas[0])
            celdas = ', '.join('[' + inline(c) + ']' for f in filas for c in f)
            out.append('#table(columns: (auto,) + (1fr,) * %d, inset: 4pt, stroke: 0.4pt + luma(60%%), %s)' % (n - 1, celdas))
            continue
        if l.startswith('- '):
            out.append('- ' + inline(l[2:])); i += 1; continue
        out.append(inline(l)); i += 1
    return '\n'.join(x for x in out if x is not None) + '\n'


if __name__ == '__main__':
    sys.stdout.write(convertir(Path(sys.argv[1]).read_text(encoding='utf-8')))
