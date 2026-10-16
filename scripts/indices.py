#!/usr/bin/env python3
"""Borrador de índices: nombres, citas bíblicas, refs [NNN], sesiones.
Uso (desde la raíz): python3 scripts/indices.py  →  docs/INDICES-borrador.md (para curaduría).
"""
import re
from pathlib import Path
from collections import defaultdict

EDIDIR = Path(__file__).parent.parent / 'edicion'
DOCS = Path(__file__).parent.parent / 'docs'
lotes = [EDIDIR / f'lote{i}-pp*.md'.replace('*', a) for i, a in
         [(1, '055-109'), (2, '110-164'), (3, '165-218')]]

def pages_of(pat, flags=0):
    out = defaultdict(list)
    for f in lotes:
        for m in re.finditer(pat, f.read_text(encoding='utf-8'), flags):
            pg = None
            # página por clave de nota más cercana hacia atrás... aproximación: buscar [^PPP- en los 400 chars previos
            prev = f.read_text(encoding='utf-8')[:m.start()]
            ks = re.findall(r'\[\^(t\d+b?-\d+[a-z0-9-]*|\d{3}-\d+[a-z0-9-]*)', prev[-400:])
            k = ks[-1] if ks else '?'
            pg = {'t01': '55-56', 't01b': '55-56', 't02': '57-58', 't03': '59-60',
                  't04': '61-62', 't05': '63-64'}.get(k.split('-')[0], k.split('-')[0] if '-' in k and k[:1].isdigit() else k)
            out[m.group(0)].append(pg)
    return out

NAMES = ['Luther', 'Ecci', 'Carolostad', 'Augustinus', 'Augustin', 'Hieronym', 'Cyprian',
         'Thom', 'Gregor', 'Bernhard', 'Dionysi', 'Aristotel', 'Pelagi', 'Huss', 'Wiclef',
         'Origen', 'Chrysostom', 'Ambrosi', 'Nicol', 'Innocent', 'Alexander', 'Leo',
         'Sylvest', 'Constantin', 'Damas', 'Corneli', 'Hilari', 'Basili', 'Athanasi',
         'Petr', 'Paul', 'Christ', 'Moses', 'Moysi', 'David', 'Salomon', 'Aaron']
BOOKS = ['Psalm', 'Psal', 'Matth', 'Marc', 'Luc', 'Johann', 'Actuum', 'Act', 'Rom', 'Corinth',
         'Galat', 'Ephes', 'Timoth', 'Titum', 'Hebrae', 'Apocalyps', 'Genes', 'Esai', 'Ezech',
         'Eccles', 'Sapient', 'Petri', 'Jacobi', 'Judae']

L = ['# Índices (borrador automático — curar)', '']
L.append('## Nombres (formas y páginas impresas)')
for n in NAMES:
    d = pages_of(n)
    tot = sum(len(set(v)) for v in d.values())
    if tot:
        forms = ', '.join(f'{k} ({len(set(v))}pp)' for k, v in sorted(d.items()))
        allp = sorted({p for v in d.values() for p in v if p != '?'}, key=lambda x: (not x[:1].isdigit(), x))
        L.append(f'- **{n}**: {forms} → pp. {", ".join(allp[:40])}')
L.append('')
L.append('## Citas bíblicas (libro → páginas)')
for b in BOOKS:
    d = pages_of(r'\b' + b + r'\w*\.?(?:\s*\d+)?(?:\s*\[v\.\s*\d+[^\]]*\])?')
    allp = sorted({p for v in d.values() for p in v if p != '?'}, key=lambda x: (not x[:1].isdigit(), x))
    if allp:
        L.append(f'- **{b}**: pp. {", ".join(allp[:40])} [{sum(len(set(v)) for v in d.values())} menc.]')
L.append('')
L.append('## Referencias [NNN] del impreso')
refs = defaultdict(list)
for f in lotes:
    t = f.read_text(encoding='utf-8')
    for m in re.finditer(r'\[(\d{3})\]', t):
        prev = t[:m.start()]
        ks = re.findall(r'\[\^(\d{3})-\d', prev[-400:])
        refs[m.group(1)].append(ks[-1] if ks else '?')
for r in sorted(refs):
    L.append(f'- [{r}]: pp. {", ".join(sorted(set(refs[r])))}')
L.append('')
L.append('## Sesiones (días y horas)')
for f in lotes:
    for m in re.finditer(r'(Die \w+ \w+ mensis \w+|Hora \w+.*?disputa\w*|quarta die Julii|nona.*?Julii|Saturni|Veneris|Lunae)[^\n]{0,80}', f.read_text(encoding='utf-8')):
        L.append(f'- {m.group(0).strip()[:110]}')
(DOCS / 'INDICES-borrador.md').write_text('\n'.join(L) + '\n', encoding='utf-8')
print('\n'.join(L[:14]), '\n... total líneas:', len(L))
