#!/usr/bin/env python3
"""Convierte un lote MD (cuerpo + definiciones) a fragmento .typ sin preámbulo
(solo importa `apnota` de edicion/comun/aparato.typ).
Uso: python3 md2typ.py edicion/lotes/lote1-pp055-109.md > edicion/fragmentos/lote1.typ
     (--titulo-inicial: la primera línea es un encabezado de segundo nivel)
- [^key] -> #apnota("etiqueta")[definición]  (#apnota se define en edicion/comun/aparato.typ)
- La etiqueta es la del impreso: la clave sin el prefijo de página/fragmento y
  sin los sufijos de desambiguación (065-14-2 -> 14; t03-21b2 -> 21b).
- Las definiciones consumidas desaparecen del flujo; las sin llamada van a un
  párrafo final visible. Los comentarios de empalme se eliminan; cualquier otro
  comentario HTML se vuelve nota visible en cursiva (salvo los avisos de
  trabajo del piloto, `test-p…`, que se omiten).
- Escapa los caracteres con significado en Typst y evita las sustituciones
  tipográficas automáticas (--, ..., comillas) para no alterar el texto.
"""
import re, sys
from pathlib import Path

ESPECIALES = '\\#$*_@<>[]`~'


def esc(s):
    s = ''.join('\\' + c if c in ESPECIALES else c for c in s)
    s = s.replace('//', '\\/\\/').replace('/*', '\\/*')
    s = s.replace('...', '.\\.\\.').replace('--', '-\\-')
    return s


def etiqueta(clave):
    partes = clave.split('-')
    et = partes[1] if len(partes) > 1 else partes[0]
    return re.sub(r'^(\d+[a-z])\d+$', r'\1', et)


def convertir(src, titulo=False):
    defs = dict(re.findall(r'^\[\^([^\]]+)\]:\s?(.*)$', src, re.M))
    lineas, usadas = [], []
    for l in src.splitlines():
        if re.match(r'^\[\^[^\]]+\]:', l):
            continue
        m = re.match(r'^\s*<!--(.*?)-->\s*$', l)
        if m:
            interno = m.group(1).strip()
            # empalme: lo consume el ensamblaje; test-p…: aviso de trabajo del piloto
            if not interno.startswith(('empalme:', 'test-p')):
                # una clave citada en el comentario no es una llamada
                interno = re.sub(r'\[\^([^\]]+)\]', r'\1', interno)
                lineas.append('\x03' + interno + '\x04')
            continue
        # al inicio de línea, Typst interpreta -, +, =, / y "1." como marcas
        if re.match(r'^\s*([-+=/]|\d+\.)(\s|$)', l):
            l = re.sub(r'^(\s*)', r'\1\\', l, count=1)
        lineas.append(l)
    if titulo:   # la primera línea no vacía es un encabezado (p. ej. «A. Las fuentes.»)
        k = next(i for i, l in enumerate(lineas) if l.strip())
        lineas[k] = '\x05' + lineas[k].strip() + '\x06'
    cuerpo = '\n'.join(lineas).strip()

    # primero se escapa el texto, luego se insertan las llamadas (que llevan
    # sus propios corchetes)
    partes = re.split(r'(\[\^[^\]]+\])', cuerpo)
    salida = []
    for p in partes:
        m = re.fullmatch(r'\[\^([^\]]+)\]', p)
        if m and m.group(1) in defs:
            usadas.append(m.group(1))
            salida.append('\x00NOTA%s\x01%s\x02' % (etiqueta(m.group(1)), defs[m.group(1)]))
        else:
            salida.append(esc(p))
    texto = ''.join(salida)

    def expandir(m):
        et, d = m.group(1), m.group(2)
        return '#apnota("%s")[%s]' % (et.replace('"', '\\"'), esc(d))

    texto = re.sub('\x05([^\x06]*)\x06', r'== \1', texto)
    texto = re.sub('\x03([^\x04]*)\x04', r'#emph[\\[\1\\]]', texto)
    texto = re.sub('\x00NOTA([^\x01]*)\x01([^\x02]*)\x02', expandir, texto)
    # una llamada seguida de «.letra» se leería como acceso a un campo
    texto = re.sub(r'(#apnota\("[^"]*"\)\[(?:[^\]\\]|\\.)*\])(?=\.[A-Za-z_])', '\\1\u200b', texto)

    sin_llamada = [(k, v) for k, v in defs.items() if k not in usadas]
    if sin_llamada:
        texto += ('\n\n#emph[Notas del aparato sin llamada en el cuerpo:] '
                  + '; '.join('\\[%s\\] %s' % (esc(etiqueta(k)), esc(v)) for k, v in sin_llamada) + '\n')
    return '#import "../comun/aparato.typ": apnota\n\n' + texto


if __name__ == '__main__':
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    sys.stdout.write(convertir(Path(args[0]).read_text(encoding='utf-8'), titulo='--titulo-inicial' in sys.argv))
