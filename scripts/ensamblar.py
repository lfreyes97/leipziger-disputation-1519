#!/usr/bin/env python3
"""Ensambla páginas transcripcion/pp-PPP.md (o traduccion/trad-pp-PPP.md) en lotes markdown.
Uso:
  python3 ensamblar.py lote1 55 109    -> edicion/lotes/lote1-pp055-109.md
  python3 ensamblar.py trad1 55 109    -> edicion/lotes/trad1-pp055-109.md
  python3 ensamblar.py tradintro 1 11  -> edicion/lotes/tradintro-pp001-011.md (intro de Seitz; `intro` = alemán)
  python3 ensamblar.py --check transcripcion/pp-065.md [...]  (verifica claves)
Reglas:
- Orden numérico. Unión con '\\n\\n', salvo que el archivo previo termine en
  palabra con guion ('omni-'): se quita el guion y se pega con la primera
  línea del siguiente (empalme).
- Las claves [^PPP-N] ya son únicas por página; no se reescriben.
- Los lotes llevan una marca `<!--pag:NNN-->` al comienzo de cada página impresa.
- En la introducción de Seitz (`intro`, `tradintro`), prosa continua: si una página
  termina sin puntuación final, la frase sigue en la siguiente y se unen con espacio.
"""
import re, sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
TRANSDIR = ROOT / 'transcripcion'
TRADDIR = ROOT / 'traduccion'
EDIDIR = ROOT / 'edicion' / 'lotes'

def load(p):
    return p.read_text(encoding='utf-8').strip() + '\n'

def strip_comments(text):
    return re.sub(r'<!--.*?-->', '', text, flags=re.S)

def check(text, name):
    text = strip_comments(text)
    defs = set(re.findall(r'^\[\^([^\]]+)\]:', text, re.M))
    marks = set(re.findall(r'\[\^([^\]]+)\]', text)) - defs
    # los usos en definiciones no cuentan: quitar líneas de def
    body = '\n'.join(l for l in text.splitlines() if not re.match(r'^\[\^[^\]]+\]:', l))
    used = set(re.findall(r'\[\^([^\]]+)\]', body))
    missing = used - defs
    unused = defs - used
    print(f'{name}: defs={len(defs)} usadas={len(used)} faltantes={sorted(missing)} sin_uso={sorted(unused)}')
    return not missing

def split_body_defs(text):
    body_lines, def_lines = [], []
    for l in text.splitlines():
        if re.match(r'^\[\^[^\]]+\]:', l) or l.strip().startswith('<!--'):
            def_lines.append(l)
        else:
            body_lines.append(l)
    return '\n'.join(body_lines).strip(), '\n'.join(def_lines).strip()

def assemble(files, continuo=False, marcas=False):
    """marcas=True deja `<!--pag:NNN-->` al comienzo de cada página (la usa el índice
    y la paginación de Seitz en el margen)."""
    bodies, alldefs = [], []
    for f in files:
        t = load(f)
        # solo el andamiaje de empalme se elimina (otros comentarios, como la
        # glosa de pp-114, se conservan con las definiciones)
        t = re.sub(r'\s*<!--\s*empalme:.*?-->', '', t, flags=re.S)
        b, d = split_body_defs(t)
        bodies.append((f, b))
        if d:
            alldefs.append(d)

    def marca(f):
        m = re.search(r'(\d{3})\.md$', f.name)
        return f'<!--pag:{m.group(1)}-->' if marcas and m else ''

    f0, b0 = bodies[0]
    out = (marca(f0) + '\n' if marca(f0) else '') + b0
    for f, b in bodies[1:]:
        mk = marca(f)
        if re.search(r'[\w)]-$', out) and re.match(r'\w', b):
            # palabra partida entre páginas: la marca va tras la primera palabra
            b = b.lstrip()
            b = re.sub(r'^(\w+)', lambda m: m.group(1) + mk, b, count=1) if mk else b
            out = out[:-1] + b
        elif continuo and re.search(r'[^.:;?!»\"\')—\s]$', re.sub(r'\[\^[^\]]+\]$', '', out)):
            out += ' ' + b    # prosa continua: la frase sigue en la página siguiente
        else:
            out += '\n\n' + (mk + '\n' if mk else '') + b
    return out + '\n\n' + '\n'.join(alldefs) + '\n'

if __name__ == '__main__':
    if sys.argv[1] == '--check':
        ok = all(check(load(Path(a)), a) for a in sys.argv[2:])
        sys.exit(0 if ok else 1)
    name, a, b = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
    if name == 'tradintro':    # introducción de Seitz traducida (impresas 1-11)
        files = [TRADDIR / f'trad-intro-pp-{p:03d}.md' for p in range(a, b + 1)]
    elif name == 'intro':      # introducción de Seitz en alemán
        files = [TRANSDIR / f'intro-pp-{p:03d}.md' for p in range(a, b + 1)]
    elif name.startswith('trad'):
        files = [TRADDIR / f'trad-pp-{p:03d}.md' for p in range(a, b + 1)]
    else:
        files = [TRANSDIR / f'pp-{p:03d}.md' for p in range(a, b + 1)]
    missing = [str(f) for f in files if not f.exists()]
    if missing:
        print('FALTAN:', *missing); sys.exit(2)
    out = assemble(files, continuo=name in ('intro', 'tradintro'),
                   marcas=not name.endswith('intro'))
    dest = EDIDIR / f'{name}-pp{a:03d}-{b:03d}.md'
    dest.write_text(out, encoding='utf-8')
    print('escrito', dest, len(out), 'chars')
