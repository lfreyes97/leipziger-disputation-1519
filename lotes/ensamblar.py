#!/usr/bin/env python3
"""Ensambla páginas lotes/pp-PPP.md en lotes markdown.
Uso:
  python3 ensamblar.py lote1 55 109    -> lotes/lote1-pp055-109.md
  python3 ensamblar.py --check pp-065.md [pp-066.md ...]  (verifica claves)
Reglas:
- Orden numérico. Unión con '\\n\\n', salvo que el archivo previo termine en
  palabra con guion ('omni-'): se quita el guion y se pega con la primera
  línea del siguiente (empalme).
- Reescritura de claves por fragmento para unicidad global: [^065-14] ya es
  única por página; los test-p0X.md viejos (claves simples) se prefijan [^t02-10].
"""
import re, sys
from pathlib import Path

LOTES = Path(__file__).parent

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

def prefix_keys(text, tag):
    def rep_def(m):
        return f'[^{tag}-{m.group(1)}]:'
    text = re.sub(r'^\[\^([^\]]+)\]:', rep_def, text, flags=re.M)
    # marcadores: evitar los ya prefijados en esta pasada (def ya convertidas no matchean el siguiente porque terminan en ':')
    text = re.sub(r'\[\^([^\]]+)\]', lambda m: f'[^{tag}-{m.group(1)}]' if not m.group(1).startswith(tag + '-') else m.group(0), text)
    return text

def split_body_defs(text):
    body_lines, def_lines = [], []
    for l in text.splitlines():
        if re.match(r'^\[\^[^\]]+\]:', l) or l.strip().startswith('<!--'):
            def_lines.append(l)
        else:
            body_lines.append(l)
    return '\n'.join(body_lines).strip(), '\n'.join(def_lines).strip()

def assemble(files, ids):
    bodies, alldefs = [], []
    for f, tag in zip(files, ids):
        t = load(f)
        if tag:
            t = prefix_keys(t, tag)
        # solo el andamiaje de empalme se elimina (otros comentarios, como la
        # glosa de pp-114, se conservan con las definiciones)
        t = re.sub(r'\s*<!--\s*empalme:.*?-->', '', t, flags=re.S)
        b, d = split_body_defs(t)
        bodies.append(b)
        if d:
            alldefs.append(d)
    out = bodies[0]
    for b in bodies[1:]:
        if re.search(r'[\w)]-$', out) and re.match(r'\w', b):
            out = out[:-1] + b.lstrip()
        else:
            out += '\n\n' + b
    return out + '\n\n' + '\n'.join(alldefs) + '\n'

if __name__ == '__main__':
    if sys.argv[1] == '--check':
        ok = all(check(load(Path(a)), a) for a in sys.argv[2:])
        sys.exit(0 if ok else 1)
    name, a, b = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
    files, ids = [], []
    if name.startswith('trad'):
        # tramo test traducido + páginas traducidas (claves ya únicas, sin prefijos)
        for t in ['trad-t01', 'trad-t01b', 'trad-t02', 'trad-t03', 'trad-t04', 'trad-t05']:
            if a < 65:
                files.append(LOTES / f'{t}.md'); ids.append(None)
        for p in range(max(a, 65), b + 1):
            files.append(LOTES / f'trad-pp-{p:03d}.md'); ids.append(None)
        dest = LOTES / f'{name}-pp{a:03d}-{b:03d}.md'
    else:
        # fragmentos test ya hechos cubren 55-64
        testmap = [('output-test/test-p01.md', 't01'), ('output-test/test-p01b.md', 't01b'),
                   ('output-test/test-p02.md', 't02'), ('output-test/test-p03.md', 't03'),
                   ('output-test/test-p04.md', 't04'), ('output-test/test-p05.md', 't05')]
        root = LOTES.parent
        if a < 65:
            for f, tag in testmap:
                files.append(root / f); ids.append(tag)
        for p in range(max(a, 65), b + 1):
            files.append(LOTES / f'pp-{p:03d}.md'); ids.append(None)  # ya namespaced por página
        dest = LOTES / f'{name}-pp{a:03d}-{b:03d}.md'
    missing = [str(f) for f in files if not f.exists()]
    if missing:
        print('FALTAN:', *missing); sys.exit(2)
    out = assemble(files, ids)
    dest = LOTES / f'{name}-pp{a:03d}-{b:03d}.md'
    dest.write_text(out, encoding='utf-8')
    print('escrito', dest, len(out), 'chars')
