#!/usr/bin/env python3
"""Marcas de índice. Lee edicion/indice-entradas.json y
  - marcar(texto, esc, idioma): envuelve en `#clave[…]` las formas de la tabla (para md2typ, md2lectura);
  - al ejecutarse, escribe edicion/comun/entradas.typ con un comando por entrada
    (`#agustin[…]` = texto + entrada del índice de personas).
Uso: python3 scripts/indice_marcas.py"""
import json, re, sys
from pathlib import Path

RAIZ = Path(__file__).parent.parent
TABLA = RAIZ / 'edicion' / 'indice-entradas.json'
LETRA = r'[\wÀ-ſ]'


def cargar():
    d = json.loads(TABLA.read_text(encoding='utf-8'))
    return [(cat, e) for cat, lista in d.items() if isinstance(lista, list) for e in lista]


def patron(idioma):
    """Una expresión que reconoce cualquier forma de la lengua dada; el grupo con nombre dice cuál."""
    partes = [f'(?P<{e["clave"]}>{e[idioma]})' for _, e in cargar() if idioma in e]
    return re.compile(f'(?<!{LETRA})(?:' + '|'.join(partes) + f')(?!{LETRA})')


def marcar(texto, esc, idioma):
    """Devuelve `texto` escapado con esc(); las formas de la tabla van envueltas en #clave[…]
    entre marcadores \\x10 (protegidos del escape posterior)."""
    pat = patron(idioma)
    salida, pos = [], 0
    for m in pat.finditer(texto):
        salida.append(esc(texto[pos:m.start()]))
        sig = texto[m.end():m.end() + 1]
        guarda = '​' if sig in ('(', '[') else ''
        salida.append(f'\x10#{m.lastgroup}[{m.group(0)}]{guarda}\x10')
        pos = m.end()
    salida.append(esc(texto[pos:]))
    return ''.join(salida)


def escribir_typ():
    lineas = ['// Generado por scripts/indice_marcas.py desde edicion/indice-entradas.json: no se edita.',
              '#import "indice.typ": indexar', '']
    for cat, e in cargar():
        lineas.append(f'#let {e["clave"]} = indexar.with("{cat}", "{e["nombre"]}")')
    (RAIZ / 'edicion' / 'comun' / 'entradas.typ').write_text('\n'.join(lineas) + '\n', encoding='utf-8')


if __name__ == '__main__':
    escribir_typ()
    print('escrito edicion/comun/entradas.typ')
