"""Reconocimiento de las etiquetas de orador en latín y en español.
es_orador(linea) -> (ref, etiqueta) o None; ref es el número de [NNN] si la línea lo lleva."""
import re

LA = re.compile(r'^(\[\d+\]\s*)?((Dominus|D\.)\s+)+(doctor\s+)?(Martinus|Eccius)\.\s*$')
ES = re.compile(r'^(\[\d+\]\s*)?El\s+(se[ñn]or\s+)?(doctor\s+)?((D\.\s+)+)?(doctor\s+)?(Mart[íi]n|Eck)\.\s*$')


def es_orador(linea):
    s = linea.strip()
    if not (LA.match(s) or ES.match(s)):
        return None
    ref = re.match(r'\[(\d+)\]', s)
    return (ref.group(1) if ref else None, re.sub(r'^\[\d+\]\s*', '', s))
