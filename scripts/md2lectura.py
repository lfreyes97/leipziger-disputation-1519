#!/usr/bin/env python3
"""Edición de LECTURA desde un lote MD: sin aparato, oradores como encabezados,
refs [NNN] al margen (TeX) o en línea (MD).
Uso: python3 md2lectura.py lotes/lote1-pp055-109.md --tex lotes/lec1.tex --md lotes/lec1-pp055-109.md
"""
import re, sys, argparse

LA = re.compile(r'^(\[\d+\]\s*)?((Dominus|D\.)\s+)+(doctor\s+)?(Martinus|Eccius)\.\s*$')
ES = re.compile(r'^El\s+(se[ñn]or\s+)?(doctor\s+)?((D\.\s+)+)?(doctor\s+)?(Mart[íi]n|Eck)\.\s*$')

def esc(s):
    s = s.replace('\\', r'\textbackslash{}')
    for a, b in [('&', r'\&'), ('%', r'\%'), ('$', r'\$'), ('#', r'\#'),
                 ('_', r'\_'), ('{', r'\{'), ('}', r'\}'),
                 ('~', r'\textasciitilde{}'), ('^', r'\textasciicircum{}')]:
        s = s.replace(a, b)
    return s

ap = argparse.ArgumentParser()
ap.add_argument('src')
ap.add_argument('--tex', required=True)
ap.add_argument('--md', required=True)
a = ap.parse_args()

src = open(a.src, encoding='utf-8').read()
lines = [l for l in src.splitlines()
         if not re.match(r'^\[\^[^\]]+\]:', l) and not l.strip().startswith('<!--')]
lines = [re.sub(r'\[\^[^\]]+\]', '', l) for l in lines]  # por si quedó algún marcador

tout, mout = [], []
for l in lines:
    s = l.strip()
    if s == 'II.':
        tout.append(r'\section*{II.}'); mout.append('## II.')
        continue
    m = LA.match(s) or ES.match(s)
    if m:
        ref = re.match(r'\[(\d+)\]', s)
        label = re.sub(r'^\[\d+\]\s*', '', s)
        if ref:
            tout.append(r'\marginpar{\small[%s]}' % ref.group(1))
            mout.append(f'> [{ref.group(1)}]')
        tout.append(r'\paragraph*{%s}' % esc(label))
        mout.append(f'### {label}')
        continue
    t = re.sub(r'\[(\d{3})\]', r'\\marginpar{\\small[\g<1>]}', esc(s))
    tout.append(t)
    mout.append(re.sub(r'\s+', ' ', s))

open(a.tex, 'w', encoding='utf-8').write('\n'.join(tout) + '\n')
open(a.md, 'w', encoding='utf-8').write('\n\n'.join(m for m in mout if m is not None) + '\n')
n = sum(1 for l in tout if l.startswith('\\paragraph'))
print(a.src, '→ oradores:', n)
