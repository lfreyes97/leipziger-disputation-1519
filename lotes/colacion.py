#!/usr/bin/env python3
"""Colación transcripción ↔ OCR ABBYY (palabra por página).
Cubre impresas 65-218 (OBJECT = PDF-1 = impresa+7). Las pp. 55-64 se colacionaron
a ojo contra imagen (máxima garantía) y se excluyen aquí.
Uso: python3 colacion.py  →  lotes/colacion-reporte.md
- SOSPECHOSA-A: palabra OCR de alta confianza (>=60) ausente en la nuestra → posible omisión.
- SOSPECHOSA-B: palabra nuestra (len>=4) ausente en OCR → posible añadido o fallo OCR.
  Ambas métricas tienen ruido (guiones, `rn/m`); el ranking prioriza revisión humana.
"""
import re, xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).parent.parent
LOTES = Path(__file__).parent
NS = None

def norm(w):
    w = w.strip().lower().strip('.,;:!?()[]{}"\'«»‘’‚„*^0123456789')
    w = w.rstrip('-¬=')
    return w

def ocr_words(idx, minconf=0):
    h = OBJS[idx].find('HIDDENTEXT')
    out = []
    for w in h.findall('.//WORD'):
        try:
            c = int(w.get('x-confidence', '0'))
        except ValueError:
            c = 0
        if c >= minconf and w.text:
            t = norm(w.text)
            if len(t) >= 3:
                out.append(t)
    return out

def our_words(path):
    t = Path(path).read_text(encoding='utf-8')
    t = re.sub(r'<!--.*?-->', ' ', t, flags=re.S)
    t = re.sub(r'\[\^[^\]]+\](:[^\n]*)?', ' ', t)  # marcadores y definiciones fuera del flujo... (defs aparte)
    toks = [norm(w) for w in re.findall(r"[A-Za-zäöüÄÖÜßſ]+", t)]
    return [w for w in toks if len(w) >= 3]

def defs_words(path):
    t = Path(path).read_text(encoding='utf-8')
    defs = re.findall(r'^\[\^[^\]]+\]:\s?(.*)$', t, re.M)
    toks = []
    for d in defs:
        toks += [norm(w) for w in re.findall(r"[A-Za-zäöüÄÖÜßſ]+", d)]
    return [w for w in toks if len(w) >= 3]

OBJS = ET.parse(ROOT / 'derauthentischet00eckj_djvu.xml').getroot().findall('.//OBJECT')
assert len(OBJS) == 258, len(OBJS)

rows = []
for p in range(65, 219):
    ocr_hi = set(ocr_words(p + 7, 60))
    ocr_all = set(ocr_words(p + 7, 0))
    ours = set(our_words(LOTES / f'pp-{p:03d}.md')) | set(defs_words(LOTES / f'pp-{p:03d}.md'))
    miss = sorted(w for w in ocr_hi - ours if len(w) >= 4)          # A: OCR seguro que nos falta
    extra = sorted(w for w in ours - ocr_all if len(w) >= 4)        # B: nuestro no visto por OCR
    rows.append((p, miss, extra))

rows_A = sorted(rows, key=lambda r: -len(r[1]))[:25]
rows_B = sorted(rows, key=lambda r: -len(r[2]))[:25]

L = ['# Colación automática — transcripción vs OCR ABBYY', '',
     'Impresas 65–218. A = palabra OCR (conf≥60) ausente en la nuestra (posible omisión).',
     'B = palabra nuestra ausente en OCR (posible añadido o fallo OCR). Ruido esperado.', '']
L.append('## Top-A (revisar omisiones)')
for p, miss, extra in rows_A:
    L.append(f'- p.{p}: {len(miss)} → {", ".join(miss[:14])}')
L.append('')
L.append('## Top-B (revisar añadidos)')
for p, miss, extra in rows_B:
    L.append(f'- p.{p}: {len(extra)} → {", ".join(extra[:14])}')
(LOTES / 'colacion-reporte.md').write_text('\n'.join(L) + '\n', encoding='utf-8')
print('\n'.join(L[:12]))
print('...')
med_A = sorted(len(r[1]) for r in rows)[len(rows)//2]
med_B = sorted(len(r[2]) for r in rows)[len(rows)//2]
print(f'mediana A={med_A} B={med_B} (ruido de fondo)')
