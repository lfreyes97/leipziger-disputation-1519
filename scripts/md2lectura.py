#!/usr/bin/env python3
"""Edición de LECTURA desde un lote MD: sin aparato, oradores como encabezados,
refs [NNN] en gris (Typst) o en línea (MD).
Uso: python3 md2lectura.py edicion/lotes/lote1-pp055-109.md --typ edicion/fragmentos/lec1.typ --md edicion/lotes/lec1-pp055-109.md
"""
import re, sys, argparse

sys.path.insert(0, __import__('os').path.dirname(__import__('os').path.abspath(__file__)))
from oradores import es_orador
from indice_marcas import marcar

ESPECIALES = '\\#$*_@<>[]`~'


def esc_p(s):
    return ''.join(t if t.startswith('\x10') else (marcar(t, esc, IDIOMA) if IDIOMA else esc(t))
                   for t in re.split('(\x10[^\x10]*\x10)', s))


def esc(s):
    s = ''.join('\\' + c if c in ESPECIALES else c for c in s)
    s = s.replace('//', '\\/\\/').replace('/*', '\\/*')
    s = s.replace('...', '.\\.\\.').replace('--', '-\\-')
    return s


ap = argparse.ArgumentParser()
ap.add_argument('src')
ap.add_argument('--typ', required=True)
ap.add_argument('--md', required=True)
ap.add_argument('--idioma', choices=['la', 'es'])
a = ap.parse_args()
IDIOMA = a.idioma

src = open(a.src, encoding='utf-8').read()
lines, pendiente, inicio = [], None, []
for l in src.splitlines():
    if re.match(r'^\[\^[^\]]+\]:', l):
        continue
    mp = re.fullmatch(r'\s*<!--pag:(\d+)-->\s*', l)
    if mp:
        pendiente = int(mp.group(1))
        continue
    if l.strip().startswith('<!--'):
        continue
    l = re.sub(r'\[\^[^\]]+\]', '', l)  # por si quedó algún marcador
    l = re.sub(r'<!--pag:(\d+)-->', lambda m: '\x10#pag(%d)\x10' % int(m.group(1)), l)
    lines.append(l)
    inicio.append(pendiente if l.strip() else None)
    if l.strip():
        pendiente = None

def sin_marcas(t):
    return re.sub('\x10[^\x10]*\x10', '', t)

tout, mout, carry = [], [], None
for l, pg in zip(lines, inicio):
    s = l.strip()
    if pg:
        carry = pg
    pg = None          # la marca de página pasa al próximo texto, no a los encabezados
    if sin_marcas(s) == 'II.':
        tout.append('#seccion[II.]'); mout.append('## II.')
        continue
    o = es_orador(sin_marcas(s))
    if o:
        ref, label = o
        if ref:
            tout.append('#refimp("%s")' % ref)
            mout.append(f'> [{ref}]')
        tout.append('#orador[%s]' % esc(label))
        mout.append(f'### {label}')
        continue
    t = re.sub(r'\\\[(\d{3})\\\]', r'#refimp("\g<1>")', esc_p(s))
    if re.match(r'^([-+=/]|\d+\.)(\s|$)', t):
        t = '\\' + t
    if carry and t:
        t = '#pag(%d) ' % carry + t
        carry = None
    tout.append(t.replace('\x10', ''))
    mout.append(re.sub(r'\s+', ' ', sin_marcas(s)))

open(a.typ, 'w', encoding='utf-8').write(
    '#import "../comun/aparato.typ": orador, pag, refimp, seccion\n#import "../comun/entradas.typ": *\n\n' + '\n'.join(tout) + '\n')
open(a.md, 'w', encoding='utf-8').write('\n\n'.join(m for m in mout if m is not None) + '\n')
n = sum(1 for l in tout if l.startswith('#orador'))
print(a.src, '→ oradores:', n)
