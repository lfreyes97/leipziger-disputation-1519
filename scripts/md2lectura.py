#!/usr/bin/env python3
"""Edición de LECTURA desde un lote MD: sin aparato, oradores como encabezados,
refs [NNN] en gris (Typst) o en línea (MD).
Uso: python3 md2lectura.py edicion/lote1-pp055-109.md --typ edicion/lec1.typ --md edicion/lec1-pp055-109.md
"""
import re, sys, argparse

LA = re.compile(r'^(\[\d+\]\s*)?((Dominus|D\.)\s+)+(doctor\s+)?(Martinus|Eccius)\.\s*$')
ES = re.compile(r'^(\[\d+\]\s*)?El\s+(se[ñn]or\s+)?(doctor\s+)?((D\.\s+)+)?(doctor\s+)?(Mart[íi]n|Eck)\.\s*$')

ESPECIALES = '\\#$*_@<>[]`~'


def esc(s):
    s = ''.join('\\' + c if c in ESPECIALES else c for c in s)
    s = s.replace('//', '\\/\\/').replace('/*', '\\/*')
    s = s.replace('...', '.\\.\\.').replace('--', '-\\-')
    return s


ap = argparse.ArgumentParser()
ap.add_argument('src')
ap.add_argument('--typ', required=True)
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
        tout.append('#align(center, text(1.4em)[II.])'); mout.append('## II.')
        continue
    m = LA.match(s) or ES.match(s)
    if m:
        ref = re.match(r'\[(\d+)\]', s)
        label = re.sub(r'^\[\d+\]\s*', '', s)
        if ref:
            tout.append('#refimp("%s")' % ref.group(1))
            mout.append(f'> [{ref.group(1)}]')
        tout.append('#orador[%s]' % esc(label))
        mout.append(f'### {label}')
        continue
    t = re.sub(r'\\\[(\d{3})\\\]', r'#refimp("\g<1>")', esc(s))
    if re.match(r'^([-+=/]|\d+\.)(\s|$)', t):
        t = '\\' + t
    tout.append(t)
    mout.append(re.sub(r'\s+', ' ', s))

open(a.typ, 'w', encoding='utf-8').write(
    '#import "aparato.typ": orador, refimp\n\n' + '\n'.join(tout) + '\n')
open(a.md, 'w', encoding='utf-8').write('\n\n'.join(m for m in mout if m is not None) + '\n')
n = sum(1 for l in tout if l.startswith('#orador'))
print(a.src, '→ oradores:', n)
