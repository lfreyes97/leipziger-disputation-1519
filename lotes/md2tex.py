#!/usr/bin/env python3
"""Convierte un lote MD (cuerpo + definiciones) a fragmento .tex sin preámbulo.
Uso: python3 md2tex.py lotes/lote1-pp055-109.md > lotes/lote1.tex
- [^key] -> \\apnota{label}{def}  (label = tras el último '-'; \\apnota se define en la maestra)
- Las definiciones consumidas desaparecen del flujo; las sin llamada van a un
  párrafo final visible. Los comentarios de empalme se eliminan; cualquier otro
  comentario HTML se vuelve nota visible en itálica.
- Escapa & % $ # _ { } ~ ^ \\ en cuerpo y definiciones.
"""
import re, sys
from pathlib import Path

def esc(s):
    s = s.replace('\\', r'\textbackslash{}')
    for a, b in [('&', r'\&'), ('%', r'\%'), ('$', r'\$'), ('#', r'\#'),
                 ('_', r'\_'), ('{', r'\{'), ('}', r'\}'),
                 ('~', r'\textasciitilde{}'), ('^', r'\textasciicircum{}')]:
        s = s.replace(a, b)
    return s

src = Path(sys.argv[1]).read_text(encoding='utf-8')
defs = dict(re.findall(r'^\[\^([^\]]+)\]:\s?(.*)$', src, re.M))

out_lines, used = [], []
for l in src.splitlines():
    if re.match(r'^\[\^[^\]]+\]:', l):
        continue
    m = re.match(r'^\s*<!--(.*?)-->\s*$', l)
    if m:
        inner = m.group(1).strip()
        if inner.startswith('empalme:'):
            continue
        out_lines.append(r'\noindent\textit{[' + esc(inner) + ']}')
        continue
    out_lines.append(l)
body = '\n'.join(out_lines).strip()

def rep(m):
    k = m.group(1)
    d = defs.get(k)
    if d is None:
        return m.group(0)
    used.append(k)
    return r'\apnota{%s}{%s}' % (esc(k.split('-')[-1]), esc(d))

body = re.sub(r'\[\^([^\]]+)\]', rep, body)
unused = [(k, defs[k]) for k in defs if k not in used]
out = body
if unused:
    out += ('\n\n' + r'\noindent\textit{Notas del aparato sin llamada en el cuerpo:} '
            + '; '.join('[%s] %s' % (esc(k.split('-')[-1]), esc(v)) for k, v in unused) + '\n')
sys.stdout.write(out)
